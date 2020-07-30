---
layout: post
title: Trying again to explain stock value calculation
date: 2020-07-28 11:46 -0500
author: quorten
categories: [personal-finance]
tags: [personal-finance]
---

Okay, okay, I still don't understand how stock share prices are
calculated.  Calculating the net present value depends on all future
dividend payouts?  How can you do that since that'd be an infinite
quantity?  The idea, simply put, is by assuming that a company has
_zero growth_ or _negative growth_ over long periods of time, the cash
flow value would be constant, but the time value of money would
diminish and eventually drop to almost zero, assuming steady positive
inflation.  Obviously, now that I state these assumptions clearly, it
should be understood that this, therefore, cannot be applied generally
to all imaginable economies or quantities that can be reasonably
treated as economic quantities.

But, given that key assumption, the otherwise infinite series can
converge to a finite number.  This is explained in Investopedia's
definition of a "perpetuity."  So, now that you understand that, we
can get a bit more technical on the real dynamics of the stock market.
It turns out that the real listed share price is not actually
calculated as such per se.  The prime exception is at a company's
initial public offering (IPO), when the initial share price is
calculated precisely by the formula, that of using the net present
value of all future dividend payouts.  After that, the stock buys and
sells start having an influence on the calculated value.

Wikipedia failed to sufficiently explain, so I went web searching
elsewhere to find the answer.

<!-- more -->

20200728/https://en.wikipedia.org/wiki/Net_present_value  
20200728/DuckDuckGo how is the price of stock calculated  
20200728/https://www.investopedia.com/ask/answers/how-companys-stock-price-and-market-cap-determined/  
20200728/dividend discount model  
20200728/https://www.investopedia.com/terms/d/ddm.asp  
20200728/DuckDuckGo what determines the market value of stock  
20200728/https://www.investopedia.com/terms/m/marketvalue.asp  
20200728/DuckDuckGo how does a company calculate its share price  
20200728/https://www.investopedia.com/ask/answers/061615/how-companys-share-price-determined.asp  
20200728/https://www.investopedia.com/terms/p/perpetuity.asp

But how?  And how does a company's profit affect their share price?

You can try to put it like this.  A company's profit primarily affects
its dividend payout, which is simply the total profit divided by the
total number of shares on the stock market.  The _stock market_ then
provides another stream of profit to the company, which then factors
into the dividend payout, but only temporarily... unless the stocks
keep getting purchased as a cash flow.

How about this piece of advice?

> Corporations pay dividends as a way to share the company's profits
> with the shareholders. Companies are under no obligation or
> regulation to calculate their dividend payout a certain
> way. Investors should understand the dividend policy and philosophy
> of the stocks they own.

And the dividend payout is generally some fraction of the total
profit, though this is not required.  A company could, simply by
policy election, pay out more money per share than it earns in profits
(for a short period of time).

20200728/https://pocketsense.com/do-companies-calculate-dividends-6337976.html

So, at the bitter end of the day, it's all open to discretion, here.

But, wait, here is more insight.

> A Company does not participate in trading of their share in the
> secondary market (stock market). Companies receive money from the
> securities market only when they first sell a security to the public
> in the primary market which is commonly referred to as an IPO.

20200728/DuckDuckGo stock buy sell affect share price  
20200728/https://www.quora.com/How-does-a-massive-stock-sell-off-affect-a-company?share=1

So, after the IPO, the money from the stock market doesn't actually
factor into a company's profit statement.  The money, therefore, goes
into a secondary pool of "purchased stocks."  That separate money pool
is then what factors into a stock price, in addition to the actual (or
hypothetical) dividend payouts coming from the company.

Apparently, _bidding_ is indeed the primary means of share price
assertion.  But who then is the seller on the other side who
determines the price?  Stockbrokers.

> A potential buyer _bids_ a specific price for a stock, and a
> potential seller _asks_ a specific price for the same stock. Buying
> or selling at the _market_ means you will accept _any_ ask price or
> bid price for the stock. When the bid and ask prices match, a sale
> takes place, on a first-come, first-served basis if there are
> multiple bidders at a given price.

20200728/https://en.wikipedia.org/wiki/Stock_market  
20200728/https://en.wikipedia.org/wiki/Stockbroker

Alright, here is more insight on where the money goes after the IPO.

> But the money spent to buy the stock went to the stock's previous
> owner, which is usually not the company itself.

...

> But the important thing to understand relative to this question is
> the stocks are a one-time sale for the company. The company receives
> capital once from the initial sale, and doesn't get any input or
> return when (or if!) the stocks are bought/sold afterwards.

> The company does still care about the stock price, though, because
> of the shareholders who own those stocks (and therefore own the
> company). If the stock performs poorly, the shareholders will get
> the board to replace the company's management team (by first
> replacing board members if necessary).

Ah, and here we go, mention of how "hostile takeovers" work in more
detail.

> The other thing that can happen if the stock prices trends too low
> is the company becomes vulnerable to take-over by a rival. Remember
> ownership of stock is ownership of the company, and a rival need
> only purchase 51% of the stock to control the board -- often even
> less if there is a sympathetic investor with the ailing
> company. Thus a low stock price can be dangerous for a company's
> very existence.

And, here finally, is the statement of the minimum model requirements
for a shareholder's decision-making, though this won't be
comprehensive enough to build a model of the whole system.

> Of course, you, I, or any other average Joe are unlikely to ever
> reach the level where we have a meaningful reason to attend a
> shareholders meeting and actually vote on anything that matters to
> us[5]. We don't really care about the ownership stake so much. We
> _do_ care that stocks have shown stable and even increasing value
> over time. This makes them a useful place to park savings, that
> might even provide a good return.

Now, this is the kicker, on how share prices can increase.  Since a
listed share price already accounts for growth (ONLY at the IPO,
though, your Trader Joe does this booking on discretion forever
afterward):

> If a company is not also _growing_ as quickly as it can, it's in
> trouble. More than that, just showing good growth is often not
> enough. It must also _beat expectations_ to keep investors happy,
> because stock prices have often already accounted for expected
> growth. To raise the price further, you must _exceed_ your own
> projections, which were already often optimistic in order to keep
> investors happy in the first place. This never-easing pressure has a
> profound impact on how corporations behave.

So, yeah, a good point.  Want to know the share price after an IPO?
This is solely, 100% determined by investor decision-making.  The
continuity of a share price calculation similar to the IPO calculation
is solely based off of individual investors making their own such
calculation in agreement, which then sets the market value of the
company's stock through the resulting buys and sells that establish
the price at the agreed equilibrium.

20200728/DuckDuckGo do companies receive money from the stock market  
20200728/https://money.stackexchange.com/questions/94507/how-can-a-company-use-money-from-stock-investors-when-they-are-constantly-being

One last area of research, what is the role of stock exchanges in the
stock market?  They are the "assocation" that stockbrokers form
together when there are events that one cannot wholly handle on their
own, like list price agreement, financial debts/surpluses based off of
list price changes, and so on.

20200728/https://en.wikipedia.org/wiki/Stock_exchange

----------

So, there you have it.  Now I can summarize the few, the only hard
ground rules of the stock market.

1. A company's _bank account_ only earns money from the number of
   shares created at its Initial Public Offering (IPO) and the
   corresponding initial list price of those shares.  The calculation
   of that list price is based off of a net present value computation
   of all future dividend payments, possibly accounting for projected
   growth, and definitely assuming positive inflation so that the
   infinite series computation can be convergent on a finite number.
   Specifically, the fact that each future dividend payment will be
   the same dollar value, so therefore its value adjusting for
   inflation will be less in equivalent dollar value at the present.

2. After the IPO sale, **the company's bank account gets nothing** out
   of the stock deals.  Anything related to the stock market that
   affects the company is wholly indirect through secondary vehicles
   that base their decisions off of the stock market.  Therefore, the
   primary benefit of the stock market is to shareholders, and this is
   two-fold.

    1. Shareholders are granted a fractional payout of a company's
       profits, paid out in dividends proportional to the share of
       stocks someone owns in a company.  However, the exact terms of
       this are totally negotiable in the stock agreement, and some
       companies may agree to not have a dividend payout at all.

    2. Shareholders are granted fractional control over the company's
       board of directors decision-making.  Again, the exact terms of
       this are totally negotiable in the stock agreement.

3. How then can further stock sales happen after the IPO?  This is
   wholly based off of putting money into other investor's pockets.
   Or, in the case of a company's shares on the stock market
   decreasing, taking money out of other investor's pockets.  From a
   money flow to bank accounts standpoint, the money principally flows
   from a individual investor's bank accounts to a bank account owned
   by the stockbroker, then it can be dealt out from there back to
   individual investor's bank accounts.  (Stockbrokers themselves band
   together as an association to make the stock exchange, so from
   there they can make agreements based off of where money needs to
   flow based off of how stock prices change.)  The company's bank
   account is totally detached from all financial transactions that
   happen here.

   So, how is the share's list price determined in this market?  It's
   totally based off of crowd dynamics.  The stockbroker's
   collectively has a pool of money associated with a stock, and then
   they, through the stock exchange, arbitrate the asking price based
   off of "supply and demand" dynamics, though there isn't a finite
   supply of shares.  When more people buy the stock, they arbitrate a
   price increase.  When more people sell the stock, they arbitrate a
   price decrease.

   The problem here, is that this can leave a pool of money still
   "left on the table" after all shares have been sold.  Where does
   that money go?

   Incidentally, it can be used to help solve problems related to
   running a stock brokerage firm.  Suppose a company has an IPO,
   every IPO stock is bought, but then every single last stock is
   sold.  The problem here is that all money from purchases was sent
   directly to the company, so where does the money come from to
   fulfill sells?  Ultimately, it must come from a profit made
   elsewhere by the stockbroker.

   But, in the midst of all this crowd valuation, the fact that some
   sanity settles on prices is because of this dynamic.  There are
   people who are calculating what they believe _should_ be the
   effective value of stocks, based off of a similar calculation used
   at IPO, and will buy and sell if there is a price difference.  The
   stock exchange will increase and decrease the price accordingly,
   until it finally settles at an equilibrium that reflects the
   average of these these calculated assertions of the stock's value.

4. The most immediate secondary way in which the money in a stock can
   get into a company is through _stock options_ given as a benefit to
   employees, especially executive-level employees.  Through this
   linkage, an executive can sell their shares in a company, then move
   the earned funds from their personal bank account into the
   company's bank account.

   As an exceptional event of this, there can be an agreement for a
   "stock buyback."  The company will delist a stock from the stock
   exchange, and stock holders will get an agreed portion of the total
   money value on the stock market.  The rest will go to the company
   itself, and then no one will be left who can own stock.
