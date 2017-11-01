//+------------------------------------------------------------------+
//|                                                 PivotCluster.mq4 |
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 Black
#property indicator_color2 Green
#property indicator_color3 Red

int period,shift;
double Pivots[6];
double pp[],ppup[],ppdn[];
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   SetIndexBuffer(0,pp);
   SetIndexStyle(0,DRAW_LINE,STYLE_SOLID,2);
   SetIndexLabel(0,"mPP");

   SetIndexBuffer(1,ppup);
   SetIndexStyle(1,DRAW_LINE,STYLE_SOLID,2);
   SetIndexLabel(1,"upPP");

   SetIndexBuffer(2,ppdn);
   SetIndexStyle(2,DRAW_LINE,STYLE_SOLID,2);
   SetIndexLabel(2,"dnPP");

   if(
      Period()==PERIOD_M1
      || Period()==PERIOD_M5) period=PERIOD_H4;

   if(
      Period()==PERIOD_M15
      || Period()==PERIOD_M30
      || Period()==PERIOD_H1)    period = PERIOD_D1;

   if(
      Period()==PERIOD_H4) period=PERIOD_W1;

   if(
      Period()==PERIOD_D1
      || Period()==PERIOD_W1
      || Period()==PERIOD_MN1)   period = PERIOD_MN1;
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,const int prev_calculated,
                const datetime &time[],const double &open[],
                const double &high[],const double &low[],
                const double &close[],const long &tick_volume[],
                const long &volume[],const int &spread[])
  {
//---
   int Counted_bars,i;
   Counted_bars=IndicatorCounted();
   i=Bars-Counted_bars-1;
   while(i>=0)
     {
      shift=iBarShift(Symbol(),period,Time[i],0)+1;
      pp[i]=(iHigh(NULL,period,shift)+iLow(NULL,period,shift)+iClose(NULL,period,shift))/3;

      if(Symbol()=="EURUSD")
        {
         double egpp = (iHigh("EURGBP",period,shift)+iLow("EURGBP",period,shift)+iClose("EURGBP",period,shift))/3;
         double gupp = (iHigh("GBPUSD",period,shift)+iLow("GBPUSD",period,shift)+iClose("GBPUSD",period,shift))/3;
         if(egpp!=0 && gupp!=0)Pivots[0]=egpp*gupp;

         double eapp = (iHigh("EURAUD",period,shift)+iLow("EURAUD",period,shift)+iClose("EURAUD",period,shift))/3;
         double aupp = (iHigh("AUDUSD",period,shift)+iLow("AUDUSD",period,shift)+iClose("AUDUSD",period,shift))/3;
         if(eapp!=0 && aupp!=0)Pivots[1]=eapp*aupp;

         double enpp = (iHigh("EURNZD",period,shift)+iLow("EURNZD",period,shift)+iClose("EURNZD",period,shift))/3;
         double nupp = (iHigh("NZDUSD",period,shift)+iLow("NZDUSD",period,shift)+iClose("NZDUSD",period,shift))/3;
         if(enpp!=0 && nupp!=0)Pivots[2]=enpp*nupp;

         double ejpp = (iHigh("EURJPY",period,shift)+iLow("EURJPY",period,shift)+iClose("EURJPY",period,shift))/3;
         double ujpp = (iHigh("USDJPY",period,shift)+iLow("USDJPY",period,shift)+iClose("USDJPY",period,shift))/3;
         if(ejpp!=0 && ujpp!=0)Pivots[3]=ejpp/ujpp;

         double echpp = (iHigh("EURCHF",period,shift)+iLow("EURCHF",period,shift)+iClose("EURCHF",period,shift))/3;
         double uchpp = (iHigh("USDCHF",period,shift)+iLow("USDCHF",period,shift)+iClose("USDCHF",period,shift))/3;
         if(echpp!=0 && uchpp!=0)Pivots[4]=echpp/uchpp;

         double ecdpp = (iHigh("EURCAD",period,shift)+iLow("EURCAD",period,shift)+iClose("EURCAD",period,shift))/3;
         double ucdpp = (iHigh("USDCAD",period,shift)+iLow("USDCAD",period,shift)+iClose("USDCAD",period,shift))/3;
         if(ecdpp!=0 && ucdpp!=0)Pivots[5]=ecdpp/ucdpp;

         ArraySort(Pivots);
         ppup[i] = Pivots[5];
         ppdn[i] = Pivots[0];

        }

      i--;
     }//end while
     Comment(AccountProfit());
//---
   return(rates_total);
  }
//+------------------------------------------------------------------+
