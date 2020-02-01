---
layout: post
title: A process that I used to migrate a big CVS repository to Git
date: 2019-02-14 15:21 -0600
author: quorten
categories: [git]
tags: [git]
---

Three years ago, I put together some useful open-source software and
made some useful modifications to it in order to migrate a giant CVS
repository to Git.  I've wanted to share this information for quite a
while, but I wasn't sure of the ideal form to share it.  Recently in
the past few months, thinking things through, I became aware: of
course, if you're making modifications to this software that will tend
to become out-of-date, your goal is to create a list of instructions
that a human can follow to make similar modifications to later
versions of the software.  So, here I am, writing a blog article as my
means to this end.

As this project was very rushed with limited resources, I was unable
to make my modifications in a way that would be elegant enough to
merge to the official upstream versions of the software in question.
(Of course it would be that way if people wanted to get it done as
fast as possible!)  So, although that would be the perfect ideal where
you wouldn't need to make any modifications at all, we have to cope
with falling short of that ideal with this pretty good second place
compromise.

So, first of all, let's point out the open-source tools that I've
used.

<!-- more -->

* `cvs2svn`, this includes the tool `cvs2git` which is the main
  workhorse of the CVS to Git conversion.

  20190214/http://cvs2svn.tigris.org/

* `bfg-repo-cleaner`, this is a supplementary tool used to rid large
  binary files from the Git repository and convert them to links that
  point to a Git LFS repository instead.

  20190214/https://rtyley.github.io/bfg-repo-cleaner/

* `scala-git`, this is a helper library for `bfg-repo-cleaner`,
  written by the same author as `bfg-repo-cleaner`.  We'll need to
  make modifications to this for our hack.

  20190214/https://github.com/rtyley/scala-git

* `jgit`, this is another helper library for `bfg-repo-cleaner`,
  maintained by the Eclipse team.  We'll need to make modifications to
  this mainly to merge in the unmerged patch that enables proper
  support for the Git grafts that we use to trim repository history.

  20190214/http://www.eclipse.org/jgit/

### Build custom `jgit`

So, let's start with one of the most critical modifications, the
missing patch to `jgit`.  Find the patch that is required for the
functionality here.

20160226/http://dev.eclipse.org/mhonarc/lists/jgit-dev/msg01838.html  
20160226/https://git.eclipse.org/r/#/c/2322/7  
20160226/https://github.com/imyousuf/jgit/blob/master/tools/graft-old-history.sh

"Please implement 'grafts' support":

20160226/https://bugs.eclipse.org/bugs/show_bug.cgi?id=351297

Once you've downloaded the patch file, the next really big step is to
forward port it to the latest version of `jgit`, or at least a new
enough version to work with `bfg-repo-cleaner`.  This is a tedious
manual process that I will not go through, especially because the
exact details of how to do this changes with every newer version of
the `jgit` source code, but you get the idea.  Finally, once you've
got that patch merged, you're going to want to modify the.  Please check
out of the build and test documentation in the `jgit` repository for
more details.

Once you've got that out of the way, you're going to want to apply
another patch to `jgit` that will allow you to pass around more data
for one of our other hacks.  The diff should look something like this:

```diff
diff --git a/org.eclipse.jgit/src/org/eclipse/jgit/lib/AnyObjectId.java b/org.eclipse.jgit/src/org/eclipse/jgit/lib/AnyObjectId.java
--- a/org.eclipse.jgit/src/org/eclipse/jgit/lib/AnyObjectId.java
+++ b/org.eclipse.jgit/src/org/eclipse/jgit/lib/AnyObjectId.java
@@ -96,6 +96,12 @@ public static boolean equals(final AnyObjectId firstObjectId,
 
        int w5;
 
+       /**
+        * This is a special modification just to speed up my source
+        * code modifications to `bfg-repo-cleaner'.
+        */
+       public transient int userData;
+
        /**
         * Get the first 8 bits of the ObjectId.
         *
```

Here is my summary on how to build a custom version of Eclipse `jgit`:

1. Install a version of Maven that works (I used 3.0.3).
3. `cd jgit; git checkout jgit-bfg-hacks`
4. `mvn clean install; cd ..`; Although you'll get some test case
   failures, the install will complete and the resulting `jgit` will
   be sufficiently functional for `bfg-repo-cleaner`.
5. Note that the install process put `jgit` JAR files in your `~/.m2`
   local Maven directory.

## Build custom `scala-git`

The goal of our customizations to `scala-git` is, naturally, to use
the new variable `userData` that we've added to `jgit` so that
`bfg-repo-cleaner` can know whether it is processing a root directory
or not, and if not, act differently and know where the root directory
is.  This allows us to modify `bfg-repo-cleaner` so that it only
writes a single `.gitattributes` file to the root of the repository.
The diff should look something like this:

```diff
diff --git a/build.sbt b/build.sbt
--- a/build.sbt
+++ b/build.sbt
@@ -1,5 +1,9 @@
 import ReleaseTransformations._
 
+// resolvers += Resolver.mavenLocal
+val jgitVersionOverride = "4.1.0.201509280440-r2"
+resolvers in ThisBuild ++= jgitVersionOverride.map(_ => Resolver.mavenLocal).toSeq
+
 lazy val baseSettings = Seq(
   scalaVersion := "2.11.7",
   crossScalaVersions := Seq("2.10.5", scalaVersion.value),
diff --git a/project/Dependencies.scala b/project/Dependencies.scala
--- a/project/Dependencies.scala
+++ b/project/Dependencies.scala
@@ -3,7 +3,7 @@ import sbt._
 object Dependencies {
 
   val robertoJgit = "com.madgag" % "org.eclipse.jgit" % "3.4.0.1.1-UNOFFICIAL-ROBERTO-RELEASE"
-  val eclipseJgit = "org.eclipse.jgit" % "org.eclipse.jgit" % "4.0.1.201506240215-r"
+  val eclipseJgit = "org.eclipse.jgit" % "org.eclipse.jgit" % "4.1.0.201509280440-r2"
   val jgit = eclipseJgit
 
   val specs2 = "org.specs2" %% "specs2" % "2.3.13"
diff --git a/scala-git/src/main/scala/com/madgag/git/model/Tree.scala b/scala-git/src/main/scala/com/madgag/git/model/Tree.scala
--- a/scala-git/src/main/scala/com/madgag/git/model/Tree.scala
+++ b/scala-git/src/main/scala/com/madgag/git/model/Tree.scala
@@ -16,6 +16,8 @@
 
 package com.madgag.git.bfg.model
 
+import java.nio.charset.Charset
+
 import com.madgag.diff.MapDiff
 import org.eclipse.jgit.lib._
 import org.eclipse.jgit.treewalk.CanonicalTreeParser
@@ -26,10 +28,10 @@ import org.eclipse.jgit.lib.FileMode.TREE
 
 object Tree {
 
-  val Empty = Tree(Map.empty[FileName, (FileMode, ObjectId)])
+  val Empty = Tree(Map.empty[FileName, (FileMode, ObjectId, Boolean)])
 
   def apply(entries: Traversable[Tree.Entry]): Tree = Tree(entries.map {
-    entry => entry.name -> ((entry.fileMode, entry.objectId))
+    entry => entry.name -> ((entry.fileMode, entry.objectId, entry.isAtRoot))
   }.toMap)
 
   def apply(objectId: ObjectId)(implicit reader: ObjectReader): Tree = Tree(entriesFor(objectId))
@@ -45,7 +47,7 @@ object Tree {
     entries
   }
 
-  case class Entry(name: FileName, fileMode: FileMode, objectId: ObjectId) extends Ordered[Entry] {
+  case class Entry(name: FileName, fileMode: FileMode, objectId: ObjectId, isAtRoot: Boolean) extends Ordered[Entry] {
 
     def compare(that: Entry) = pathCompare(name.bytes, that.name.bytes, fileMode, that.fileMode)
 
@@ -73,10 +75,30 @@ object Tree {
   object Entry {
 
     def apply(treeParser: CanonicalTreeParser): Entry = {
+      implicit val UTF_8 = Charset.forName("UTF-8")
       val nameBuff = new Array[Byte](treeParser.getNameLength)
+      //// val pathBuff = treeParser.getEntryPathBuffer().clone()
+      // val pathLength = treeParser.getEntryPathLength
+      // val pathBuff = new Array[Byte](pathLength)
       treeParser.getName(nameBuff, 0)
-
-      Entry(new FileName(nameBuff), treeParser.getEntryFileMode, treeParser.getEntryObjectId)
+      // Array.copy(treeParser.getEntryPathBuffer(), 0, pathBuff, 0, pathLength)
+      /* pathBuff.copyOf(treeParser.getEntryPathBuffer(), pathBuff.length); */
+      // We must always set to false for the reason mentioned below.
+      val isAtRoot = false
+      // val isAtRoot = if (nameBuff.toSeq.equals(pathBuff.toSeq)) true else false
+      /* Debugging code.  Don't worry, I know this is working as well
+         as it has been designed to work.  However, due to the way the
+         caller uses this function, the code to determine whether we are
+         actually at the root directory is not effective.  Thus, we
+         have to use different mechanisms external to this function.
+         However, we still reuse the modifications to add the additional
+         data field, as they have already been tested.  */
+      // println(pathBuff.toSeq)
+      // println(nameBuff.toSeq)
+      // println(treeParser.toString())
+      // println(isAtRoot.toString())
+
+      Entry(new FileName(nameBuff), treeParser.getEntryFileMode, treeParser.getEntryObjectId, isAtRoot)
     }
 
   }
@@ -87,12 +109,12 @@ object Tree {
 
 }
 
-case class Tree(entryMap: Map[FileName, (FileMode, ObjectId)]) {
+case class Tree(entryMap: Map[FileName, (FileMode, ObjectId, Boolean)]) {
 
   protected def repr = this
 
   lazy val entries = entryMap.map {
-    case (name, (fileMode, objectId)) => Tree.Entry(name, fileMode, objectId)
+    case (name, (fileMode, objectId, isAtRoot)) => Tree.Entry(name, fileMode, objectId, isAtRoot)
   }
 
   lazy val entriesByType = entries.groupBy(_.fileMode.getObjectType).withDefaultValue(Seq.empty)
@@ -110,7 +132,7 @@ case class Tree(entryMap: Map[FileName, (FileMode, ObjectId)]) {
 
   lazy val blobs = TreeBlobs(entriesByType(OBJ_BLOB).flatMap {
     e => BlobFileMode(e.fileMode).map {
-      blobFileMode => e.name -> ((blobFileMode, e.objectId))
+      blobFileMode => e.name -> ((blobFileMode, e.objectId, e.isAtRoot))
     }
   }.toMap)
 
@@ -125,10 +147,10 @@ case class Tree(entryMap: Map[FileName, (FileMode, ObjectId)]) {
 
 }
 
-case class TreeBlobEntry(filename: FileName, mode: BlobFileMode, objectId: ObjectId) {
-  lazy val toTreeEntry = Tree.Entry(filename, mode.mode, objectId)
+case class TreeBlobEntry(filename: FileName, mode: BlobFileMode, objectId: ObjectId, isAtRoot: Boolean) {
+  lazy val toTreeEntry = Tree.Entry(filename, mode.mode, objectId, isAtRoot)
 
-  lazy val withoutName: (BlobFileMode, ObjectId) = (mode, objectId)
+  lazy val withoutName: (BlobFileMode, ObjectId, Boolean) = (mode, objectId, isAtRoot)
 }
 
 object TreeBlobs {
@@ -137,17 +159,19 @@ object TreeBlobs {
   implicit def entries2Object(entries: Traversable[TreeBlobEntry]) = TreeBlobs(entries)
 
   def apply(entries: Traversable[TreeBlobEntry]): TreeBlobs =
-    TreeBlobs(entries.map(e => e.filename -> ((e.mode, e.objectId))).toMap)
+    TreeBlobs(entries.map(e => e.filename -> ((e.mode, e.objectId, e.isAtRoot))).toMap)
 }
 
-case class TreeBlobs(entryMap: Map[FileName, (BlobFileMode, ObjectId)]) extends Tree.EntryGrouping {
+case class TreeBlobs(entryMap: Map[FileName, (BlobFileMode, ObjectId, Boolean)], initIsAtRoot: Boolean = false) extends Tree.EntryGrouping {
 
   lazy val entries = entryMap.map {
-    case (name, (blobFileMode, objectId)) => TreeBlobEntry(name, blobFileMode, objectId)
+    case (name, (blobFileMode, objectId, isAtRoot)) => TreeBlobEntry(name, blobFileMode, objectId, isAtRoot)
   }
 
   lazy val treeEntries = entries.map(_.toTreeEntry)
 
+  val isAtRoot = initIsAtRoot
+
   def objectId(fileName: FileName) = entryMap.get(fileName).map(_._2)
 
   def diff(otherTreeBlobs: TreeBlobs) = MapDiff(entryMap, otherTreeBlobs.entryMap)
@@ -156,8 +180,8 @@ case class TreeBlobs(entryMap: Map[FileName, (BlobFileMode, ObjectId)]) extends
 case class TreeSubtrees(entryMap: Map[FileName, ObjectId]) extends Tree.EntryGrouping {
 
   lazy val treeEntries = entryMap.map {
-    case (name, objectId) => Tree.Entry(name, TREE, objectId)
+    case (name, objectId) => Tree.Entry(name, TREE, objectId, false)
   }
 
   lazy val withoutEmptyTrees = TreeSubtrees(entryMap.filterNot(_._2 == Tree.Empty.objectId))
-}
\ No newline at end of file
+}
diff --git a/version.sbt b/version.sbt
--- a/version.sbt
+++ b/version.sbt
@@ -1 +1 @@
-version in ThisBuild := "3.3"
\ No newline at end of file
+version in ThisBuild := "3.3-root-dir"
```

Now build `scala-git` as follows.

1. Install `sbt`: 20160317/[http://www.scala-sbt.org/release/docs/Getting-Started/Setup.html#installing-sbt](http://www.scala-sbt.org/release/docs/Getting-Started/Setup.html#installing-sbt)
2. `cd scala-git; git checkout root-dir-detect`
3. `sbt`;  The first time you run `sbt`, you'll have to wait a little
   while for `sbt` to download its dependencies into `~/.sbt` and
   maybe `~/.ivy2`.
4. At the `sbt` `>` prompt, `compile`
5. At the `sbt` `>` prompt, `publishLocal`
6. At the `sbt` `>` prompt, `^D` (Control+D) to exit.  `cd ..`
7. Note that the `publishLocal` put `scala-git` JAR files in
   your `~/.ivy2` local Ivy2 directory.

### Build custom `bfg-repo-cleaner`

For customizing `bfg-repo-cleaner`, there are multiple goals:

* Use the modified `jgit` so that repositories with Git grafts
  are processed properly.

* Modify only a single `.gitattributes` file at the root of the
  repository.

* Generate a correctly formatted `.gitattributes` file even when
  regular expressions with braces in them are used.

* Convert even tiny files to Git LFS, so that the Git LFS rules are
  consistently maintained.  Purportedly the reason why
  `bfg-repo-cleaner` does not convert files smaller than 512 bytes is
  because these may be the indexes of files that have already been
  converted to Git LFS.

Your diff should look something like this:

```diff
diff --git a/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/LfsBlobConverter.scala b/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/LfsBlobConverter.scala
--- a/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/LfsBlobConverter.scala
+++ b/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/LfsBlobConverter.scala
@@ -48,37 +48,69 @@ class LfsBlobConverter(
 
   val lfsSuitableFiles: (FileName => Boolean) = f => lfsGlob(f.string)
 
-  val gitAttributesLine = s"$lfsGlobExpression filter=lfs diff=lfs merge=lfs -text"
+  val gitAttributesLines =
+    if (lfsGlobExpression.startsWith("{") &&
+        lfsGlobExpression.endsWith("}")) {
+      val extns = lfsGlobExpression.substring(1,
+        lfsGlobExpression.length - 1).split(",")
+
+      extns.map {
+        (i) => i + " filter=lfs diff=lfs merge=lfs -text"
+      }
+    } else Array(s"$lfsGlobExpression filter=lfs diff=lfs merge=lfs -text")
 
   implicit val UTF_8 = Charset.forName("UTF-8")
 
   val lfsPointerMemo = MemoUtil.concurrentCleanerMemo[ObjectId]()
   
   override def apply(dirtyBlobs: TreeBlobs) = {
+    val treeIsAtRoot = dirtyBlobs.isAtRoot
     val cleanedBlobs = super.apply(dirtyBlobs)
-    if (cleanedBlobs == dirtyBlobs) cleanedBlobs else ensureGitAttributesSetFor(cleanedBlobs)
+    // if (cleanedBlobs == dirtyBlobs) cleanedBlobs else ensureGitAttributesSetFor(cleanedBlobs)
+    /* Note: We want the `.gitattributes' to be set at the root.
+       In order for this to happen, we must make sure the following
+       function is called on a blob in the root tree.  */
+    ensureGitAttributesSetFor(cleanedBlobs, treeIsAtRoot)
   }
 
-  def ensureGitAttributesSetFor(cleanedBlobs: TreeBlobs): TreeBlobs = {
+  def ensureGitAttributesSetFor(cleanedBlobs: TreeBlobs, treeIsAtRoot: Boolean): TreeBlobs = {
     implicit lazy val inserter = threadLocalObjectDBResources.inserter()
 
     val newGitAttributesId = cleanedBlobs.entryMap.get(GitAttributesFileName).fold {
-      storeBlob(gitAttributesLine)
+      storeBlob(gitAttributesLines.fold("") { (a, i) => a + i + "\n" })
     } {
-      case (_, oldGitAttributesId) =>
+      case (_, oldGitAttributesId, isAtRoot) =>
         val objectLoader = threadLocalObjectDBResources.reader().open(oldGitAttributesId)
-        val oldAttributes = objectLoader.getCachedBytes.asInput.lines().toSeq
-
-        if (oldAttributes.contains(gitAttributesLine)) oldGitAttributesId else {
-          storeBlob((oldAttributes :+ gitAttributesLine).mkString("\n"))
+        val oldAttributes = objectLoader.getCachedBytes.asInput.lines().toSeq.toString()
+        val newAttributes = gitAttributesLines.fold(oldAttributes) { (a, i) =>
+          if (a.contains(i)) a
+          else a + i + "\n"
         }
+
+        if (oldAttributes.equals(newAttributes)) oldGitAttributesId
+        else storeBlob(newAttributes)
     }
-    cleanedBlobs.copy(entryMap = cleanedBlobs.entryMap + (GitAttributesFileName -> (RegularFile, newGitAttributesId)))
+    val isAtRoot = treeIsAtRoot ||
+      (if (cleanedBlobs.entryMap.keys.iterator.hasNext) {
+        val oneKey = cleanedBlobs.entryMap.keys.iterator.next()
+        val someEntry = cleanedBlobs.entryMap.get(oneKey)
+        val isAtRoot = someEntry match {
+          case Some(s) => s._3
+          case None => false
+        }
+        // Debugging code here, but I know this is working now.
+        // println(oneKey + " " + isAtRoot)
+        isAtRoot
+      } else false)  // We don't know for sure in this case.
+    if (isAtRoot) {
+      cleanedBlobs.copy(entryMap = cleanedBlobs.entryMap + (GitAttributesFileName -> (RegularFile, newGitAttributesId, isAtRoot)))
+    } else
+      cleanedBlobs
   }
 
   override def fix(entry: TreeBlobEntry) = {
     val cleanId = if (lfsSuitableFiles(entry.filename)) lfsPointerBlobIdForRealBlob(entry.objectId) else entry.objectId
-    (entry.mode, cleanId)
+    (entry.mode, cleanId, entry.isAtRoot)
   }
 
   val lfsPointerBlobIdForRealBlob: MemoFunc[ObjectId, ObjectId] = lfsPointerMemo { blobId: ObjectId =>
@@ -86,7 +118,6 @@ class LfsBlobConverter(
     implicit lazy val inserter = threadLocalObjectDBResources.inserter()
 
     (for {
-      blobSize <- blobId.sizeTry if blobSize > 512
       pointer <- tryStoringLfsFileFor(blobId)
     } yield storeBlob(pointer.bytes)).getOrElse(blobId)
   }
diff --git a/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/ObjectIdCleaner.scala b/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/ObjectIdCleaner.scala
--- a/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/ObjectIdCleaner.scala
+++ b/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/ObjectIdCleaner.scala
@@ -83,6 +83,7 @@ class ObjectIdCleaner(config: ObjectIdCleaner.Config, objectDB: ObjectDatabase,
 
   def uncachedClean: (ObjectId) => ObjectId = {
     objectId =>
+      objectId.userData = 1 // Indicate we are at the root of a tree
       threadLocalResources.reader().open(objectId).getType match {
         case OBJ_COMMIT => cleanCommit(objectId)
         case OBJ_TREE => cleanTree(objectId)
@@ -121,7 +122,14 @@ class ObjectIdCleaner(config: ObjectIdCleaner.Config, objectDB: ObjectDatabase,
 
     val tree = Tree(cleanedTreeEntries)
 
-    val originalBlobs = tree.blobs
+    val originalBlobs =
+      if (originalObjectId.userData != 0)
+        new TreeBlobs(tree.blobs.entryMap.map {
+         case (key : FileName, value : (BlobFileMode, ObjectId, Boolean)) =>
+           (key -> (value._1, value._2, true)) }, true)
+      else tree.blobs
+    if (originalObjectId.userData != 0) {
+    }
     val fixedTreeBlobs = treeBlobsCleaner(originalBlobs)
     val cleanedSubtrees = TreeSubtrees(treeSubtreesCleaner(tree.subtrees).entryMap.map {
       case (name, treeId) => (name, cleanTree(treeId))
@@ -141,7 +149,7 @@ class ObjectIdCleaner(config: ObjectIdCleaner.Config, objectDB: ObjectDatabase,
 
   def recordChange(originalBlobs: TreeBlobs, fixedTreeBlobs: TreeBlobs) {
     val changedFiles: Set[TreeBlobEntry] = originalBlobs.entries.toSet -- fixedTreeBlobs.entries.toSet
-    for (TreeBlobEntry(filename, _, oldId) <- changedFiles) {
+    for (TreeBlobEntry(filename, _, oldId, _) <- changedFiles) {
       fixedTreeBlobs.objectId(filename) match {
         case Some(newId) => changesByFilename.addBinding(filename, (oldId, newId))
         case None => deletionsByFilename.addBinding(filename, oldId)
diff --git a/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/TreeBlobModifier.scala b/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/TreeBlobModifier.scala
--- a/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/TreeBlobModifier.scala
+++ b/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/TreeBlobModifier.scala
@@ -28,11 +28,11 @@ trait TreeBlobModifier extends Cleaner[TreeBlobs] {
 
   val memoisedCleaner: Cleaner[TreeBlobEntry] = MemoUtil.concurrentCleanerMemo[TreeBlobEntry](Set.empty) {
     entry =>
-      val (mode, objectId) = fix(entry)
-      TreeBlobEntry(entry.filename, mode, objectId)
+      val (mode, objectId, isAtRoot) = fix(entry)
+      TreeBlobEntry(entry.filename, mode, objectId, isAtRoot)
   }
 
-  def fix(entry: TreeBlobEntry): (BlobFileMode, ObjectId) // implementing code can not safely know valid filename
+  def fix(entry: TreeBlobEntry): (BlobFileMode, ObjectId, Boolean) // implementing code can not safely know valid filename
 
   override def apply(treeBlobs: TreeBlobs) = treeBlobs.entries.map(memoisedCleaner)
 
diff --git a/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/treeblobs.scala b/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/treeblobs.scala
--- a/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/treeblobs.scala
+++ b/bfg-library/src/main/scala/com/madgag/git/bfg/cleaner/treeblobs.scala
@@ -37,7 +37,7 @@ class BlobRemover(blobIds: Set[ObjectId]) extends Cleaner[TreeBlobs] {
 class BlobReplacer(badBlobs: Set[ObjectId], blobInserter: => BlobInserter) extends Cleaner[TreeBlobs] {
   override def apply(treeBlobs: TreeBlobs) = treeBlobs.entries.map {
     case e if badBlobs.contains(e.objectId) =>
-      TreeBlobEntry(FileName(e.filename + ".REMOVED.git-id"), RegularFile, blobInserter.insert(e.objectId.name.getBytes))
+      TreeBlobEntry(FileName(e.filename + ".REMOVED.git-id"), RegularFile, blobInserter.insert(e.objectId.name.getBytes), e.isAtRoot)
     case e => e
   }
 }
diff --git a/bfg-library/src/main/scala/com/madgag/git/bfg/model/Commit.scala b/bfg-library/src/main/scala/com/madgag/git/bfg/model/Commit.scala
--- a/bfg-library/src/main/scala/com/madgag/git/bfg/model/Commit.scala
+++ b/bfg-library/src/main/scala/com/madgag/git/bfg/model/Commit.scala
@@ -55,7 +55,10 @@ case class Commit(node: CommitNode, arcs: CommitArcs) {
 }
 
 case class CommitArcs(parents: Seq[ObjectId], tree: ObjectId) {
-  def cleanWith(cleaner: ObjectIdCleaner) = CommitArcs(parents map cleaner.cleanCommit, cleaner.cleanTree(tree))
+  def cleanWith(cleaner: ObjectIdCleaner) = {
+    tree.userData = 1 // Indicate we are at the root of a tree
+    CommitArcs(parents map cleaner.cleanCommit, cleaner.cleanTree(tree))
+  }
 }
 
 object CommitNode {
diff --git a/project/dependencies.scala b/project/dependencies.scala
--- a/project/dependencies.scala
+++ b/project/dependencies.scala
@@ -2,11 +2,11 @@ import sbt._
 
 object Dependencies {
 
-  val scalaGitVersion = "3.3"
+  val scalaGitVersion = "3.3-root-dir"
 
   val jgitVersionOverride = Option(System.getProperty("jgit.version"))
 
-  val jgitVersion = jgitVersionOverride.getOrElse("4.1.0.201509280440-r")
+  val jgitVersion = jgitVersionOverride.getOrElse("4.1.0.201509280440-r2")
 
   val jgit = "org.eclipse.jgit" % "org.eclipse.jgit" % jgitVersion
 
```

Now build `bfg-repo-cleaner` as follows:

1. `cd bfg-repo-cleaner; git checkout experimental-dead-end`
2. Why is it called `experimental-dead-end`?  Because this version
   is basically an assembly of dirty hacks to get `bfg-repo-cleaner`
   to do what I wanted, and it is unlikely that these changes could
   be merged upstream and have further development build off of
   them.
3. `sbt`
4. At the `sbt` `>` prompt, `bfg/assembly`
5. At the `sbt` `>` prompt, `^D` (Control+D) to exit.
6. Look at the resulting output JAR file and copy it to your desired
   location.
7. Cleanup after all builds: `cd ..; rm -rf jgit scala-git
   bfg-repo-cleaner`

### Build custom `cvs2git`

The desired modifications for `cvs2git` are as follows:

* Fix a bug in the original code relating to its blob processing.

* Add "CVS keyword collapsing" functionality to the fast blobs
  generator.  By default, this is a feature only available in the
  slower implementation, which is purportedly more heavily used and
  better tested.

* Hack in a custom list of exceptions for binary files to avoid
  collapsing keywords in them, since this information doesn't get
  passed to the fast blobs generator code.

Your diff should look something like this:

```diff
diff --git a/cvs2svn_lib/generate_blobs.py b/cvs2svn_lib/generate_blobs.py
--- a/cvs2svn_lib/generate_blobs.py
+++ b/cvs2svn_lib/generate_blobs.py
@@ -47,12 +47,15 @@ import sys
 import os
 import tempfile
 import cPickle as pickle
+import re
 
 sys.path.insert(0, os.path.dirname(os.path.dirname(sys.argv[0])))
 
 from cvs2svn_lib.rcsparser import Sink
 from cvs2svn_lib.rcsparser import parse
 from cvs2svn_lib.rcs_stream import RCSStream
+from cvs2svn_lib.keyword_expander import collapse_keywords
 
 
 def read_marks():
@@ -126,7 +129,7 @@ class RevRecord(object):
 
 
 class WriteBlobSink(Sink):
-  def __init__(self, blobfile, marks):
+  def __init__(self, blobfile, marks, disable_kw_mods):
     self.blobfile = blobfile
 
     # A map {rev : RevRecord} for all of the revisions whose fulltext
@@ -139,6 +142,10 @@ class WriteBlobSink(Sink):
     for (rev, mark) in marks.items():
       self.revrecs[rev] = RevRecord(rev, mark)
 
+    # Should keyword modification be disabled?  This is useful for
+    # binary files.
+    self.disable_kw_mods = disable_kw_mods
+
     # The RevRecord of the last fulltext that has been reconstructed,
     # if it still is_needed():
     self.last_revrec = None
@@ -170,6 +177,18 @@ class WriteBlobSink(Sink):
       assert dependent_revrec.base is None
       dependent_revrec.base = rev
 
+  def set_expansion(self, mode):
+    """Reports the keyword expansion mode for this RCS file.
+
+    This is the value of the 'expand' header in the admin section of the
+    RCS file.  This function can only be called before admin_completed().
+
+    Parameter: MODE is a string containing the keyword expansion mode.
+    Possible values include 'o' and 'b', amongst others.
+    """
+    if mode == 'b':
+      self.disable_kw_mods = True
+
   def tree_completed(self):
     """Remove unneeded RevRecords.
 
@@ -182,11 +201,33 @@ class WriteBlobSink(Sink):
         for revrec in self.revrecs.itervalues()
         if not revrec.is_needed()
         ]
+    # NOTE: This code, as originally written, is kind of in a sticky
+    # situation.  The `is_needed()' function returns `False' either if
+    # the mark is `None' or if there are no references.  Because the
+    # mark might already be set to `None', some revisions with
+    # references might get deleted early, so the attempt to remove the
+    # reference to the base revision will fail.  However, due to the
+    # way `self.revrecs' is implemented, there is no way to tell if
+    # the base revision was already removed when attempting to remove
+    # references to the base revision.  Thus, if any `KeyError' occurs
+    # when trying to remove references in the base revision, we simply
+    # have to ignore it.
+
+    # The other option would be to do a topological sort on the
+    # revision records, but I don't think that is worth the extra
+    # effort.
     while revrecs_to_remove:
       revrec = revrecs_to_remove.pop()
       del self.revrecs[revrec.rev]
       base_revrec = self[revrec.base]
-      base_revrec.refs.remove(revrec.rev)
+      try:
+        base_revrec.refs.remove(revrec.rev)
+      except KeyError:
+        del self.revrecs[base_revrec.rev]
+        continue
+        # import pdb; pdb.set_trace()
+        # break
+        
       if not base_revrec.is_needed():
         revrecs_to_remove.append(base_revrec)
 
@@ -201,6 +242,8 @@ class WriteBlobSink(Sink):
       # This must be the last revision on trunk, for which the
       # fulltext is stored directly in the RCS file:
       assert self.last_revrec is None
+      if not self.disable_kw_mods:
+        text = collapse_keywords(text)
       if revrec.mark is not None:
         revrec.write_blob(self.blobfile, text)
       if revrec.is_needed():
@@ -215,6 +258,8 @@ class WriteBlobSink(Sink):
               self.fulltext_file, self.last_rcsstream.get_text()
               )
       self.last_rcsstream.apply_diff(text)
+      if not self.disable_kw_mods:
+        self.last_rcsstream.collapse_keywords()
       if revrec.mark is not None:
         revrec.write_blob(self.blobfile, self.last_rcsstream.get_text())
       if revrec.is_needed():
@@ -239,6 +284,8 @@ class WriteBlobSink(Sink):
       rcsstream = RCSStream(base_revrec.read_fulltext())
       base_revrec.refs.remove(rev)
       rcsstream.apply_diff(text)
+      if not self.disable_kw_mods:
+        rcsstream.collapse_keywords()
       if revrec.mark is not None:
         revrec.write_blob(self.blobfile, rcsstream.get_text())
       if revrec.is_needed():
@@ -258,7 +305,27 @@ def main(args):
       (rcsfile, marks) = pickle.load(sys.stdin)
     except EOFError:
       break
-    parse(open(rcsfile, 'rb'), WriteBlobSink(blobfile, marks))
+
+    # Unfortunately, because the architecture of the blobs generator
+    # hampers passing options to `generate_blobs.py', we must include
+    # any necessary option modifications and customizations to the
+    # source code.
+
+    # Hand-extracted CVS keyword modification exclusions from
+    # `CVSROOT/cvswrappers', customize as necessary.
+    p = re.compile(r'.*\.(avi|AVI|cur|CUR|ico|ICO|gif|GIF|jpg|JPG|'
+      r'bmp|BMP|png|PNG|tif|TIF|hlp|HLP|cnt|CNT|o|obj|OBJ|'
+      r'class|CLASS|jar|JAR|sys|SYS|zip|ZIP|dll|DLL|exe|EXE|'
+      r'exp|EXP|a|lib|LIB|so|myi|MYI|myd|MYD|isd|ISD|frm|FRM|db|DB|'
+      r'book|BOOK|fm|FM|fts|FTS|gid|GID|pdf|PDF|'
+      r'pdb|PDB|pdm|PDM|doc|DOC|tmp|TMP|xls|XLS|ppt|PPT|msm|MSM|'
+      r'rpm|RPM|vsd|VSD|tar|gz|gzip),v$')
+    if p.match(rcsfile):
+      disable_kw_mods = True
+    else:
+      disable_kw_mods = False
+    parse(open(rcsfile, 'rb'), WriteBlobSink(blobfile, marks,
+                                             disable_kw_mods))
 
   blobfile.close()
 
diff --git a/cvs2svn_lib/keyword_expander.py b/cvs2svn_lib/keyword_expander.py
--- a/cvs2svn_lib/keyword_expander.py
+++ b/cvs2svn_lib/keyword_expander.py
@@ -105,7 +105,7 @@ class _KeywordExpander:
     return 'Exp'
 
 
-_kws = 'Author|Date|Header|Id|Locker|Log|Name|RCSfile|Revision|Source|State'
+_kws = 'Author|Date|Header|Id|Locker|Log|Name|RCSfile|Revision|Source|State'
 _kw_re = re.compile(r'\$(' + _kws + r'):[^$\n]*\$')
 _kwo_re = re.compile(r'\$(' + _kws + r')(:[^$\n]*)?\$')
 
diff --git a/cvs2svn_lib/rcs_stream.py b/cvs2svn_lib/rcs_stream.py
--- a/cvs2svn_lib/rcs_stream.py
+++ b/cvs2svn_lib/rcs_stream.py
@@ -19,6 +19,8 @@
 
 from cStringIO import StringIO
 import re
+from cvs2svn_lib.keyword_expander import collapse_keywords
 
 
 def msplit(s):
@@ -306,4 +308,22 @@ class RCSStream:
         )
     return inverse_diff.getvalue()
 
+  def collapse_keywords(self):
+    """Collapse CVS keywords in the current file content.  This must
+    be performed after diffs were applied to the file content."""
+
+    i = 0; num_lines = len(self._lines)
+    while i < num_lines:
+      self._lines[i] = collapse_keywords(self._lines[i])
+      i += 1
 
```

Since these are all Python code changes, there isn't really anything
special you need to do to build this.

### Final process

Start by running your modified `cvs2git` to get a.  Add a Git graft to
trim the history to an artificial point in time, then run
`bfg-repo-cleaner` to finally clean things up to the LFS repository
version.  Or, simply run `bfg-repo-cleaner` as a faster and more
efficient way to make the Git graft official.  That's all there is to
it!

Now, for _huge_ repositories, there is one catch with running
`bfg-repo-cleaner`: you'll need a **huge** amount of memory.  When I
ran it for one particular huge conversion, I had the RAM on a VM upped
to 48 GiB to perform the conversion.  Yeah, pretty tricky, but because
the hardware resources were available, that was what we did.  This is
probably a problem that _can_ be fixed by software means with a
careful investigation of `bfg-repo-cleaner`, as this kind of memory
consumption is more due to some sort of memory leak rather than based
off of actual computational needs.

Also, here's a quick primer on using Git grafts as a means to truncate
the history of a Git repository to a starting point.  First create an
empty Git commit tree without any parents as follows:

```
git commit-tree -m 'Artifical Starting Point for cvs2git conversion'
```

Get the tree object ID of your desired cut point on the existing
commits.

```
git cat-file commit <OLD-COMMIT-ID> | grep tree
```

Now put this information together something like this:

```
echo $(git rev-parse --verify $firstcommit) $newbase >> .git/info/grafts
```
