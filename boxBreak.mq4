//+------------------------------------------------------------------+
//|                                                  MACD Sample.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright   "2005-2014, MetaQuotes Software Corp."
#property link        "http://www.mql4.com"

input double TakeProfit    =50;
input double Lots          =0.1;
input double TrailingStop  =30;
input double MACDOpenLevel =3;
input double MACDCloseLevel=2;
input int    MATrendPeriod =26;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick(void)
  {
   int amount = 100;
   int sp = 3*Point();
   int c = 0;
   if(OrdersTotal()>30)
   {
      return;
   }
   for(int i=1; i<=amount; i++)
   {
      double price =iClose(Symbol(),PERIOD_CURRENT,i);
      if((iClose(Symbol(),PERIOD_CURRENT,i+1)-iClose(Symbol(),PERIOD_CURRENT,i)>sp) &&
      (iClose(Symbol(),PERIOD_CURRENT,i)-iClose(Symbol(),PERIOD_CURRENT,i-1)<-sp))
      {
           for(int j=0; j<OrdersTotal(); j++)
           {
            OrderSelect(j,SELECT_BY_POS,MODE_TRADES);
            if(OrderSymbol()==Symbol() && OrderType()==OP_SELLLIMIT && OrderLots()==0.1&&OrderOpenPrice()==price 
            &&OrderTakeProfit()==price+Point()*50 && OrderStopLoss()==price-Point()*50)
             {
              c =1;
              break;
              }
           }
         if(c==1){
            c=0;
            continue;
         }
         OrderSend(Symbol(),OP_SELLLIMIT,0.1,price,2,price+Point()*50,price-Point()*50);

      }
      if((iClose(Symbol(),PERIOD_CURRENT,i+1)-iClose(Symbol(),PERIOD_CURRENT,i)<-sp) &&
      (iClose(Symbol(),PERIOD_CURRENT,i)-iClose(Symbol(),PERIOD_CURRENT,i-1)>sp))
      {
         for(j=0; j<OrdersTotal(); j++)
           {
            OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            if(OrderSymbol()==Symbol() && OrderType()==OP_BUYLIMIT && OrderLots()==0.1&&OrderOpenPrice()==price 
            &&OrderTakeProfit()==price+Point()*50 && OrderStopLoss()==price-Point()*50)
             {
              c=1;
              break;
              }
           }
            if(c==1){
            c=0;
            continue;
         }
         OrderSend(Symbol(),OP_BUYLIMIT,0.1,price,2,price-Point()*50,price+Point()*50);

      }
   }
  }
//+------------------------------------------------------------------+
