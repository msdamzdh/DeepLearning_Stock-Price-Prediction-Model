clc
clear
close all
data =table2timetable(readtable('Binance_BTCUSDT_2023_minute.csv'));
%% remove out of period range data
start_time = datetime(2023,2,0);
end_time = datetime(9999,12,30);
data(data.Date<start_time & data.Date>end_time,:)=[];
%% Convert to 15 minitues
Duration = duration(0,15,0);
Open = retime(data(:,'Open'),'regular','firstvalue','TimeStep',Duration);
High = retime(data(:,'High'),'regular','max','TimeStep',Duration);
Low = retime(data(:,'Low'),'regular','min','TimeStep',Duration);
Close = retime(data(:,'Close'),'regular','lastvalue','TimeStep',Duration);
Vol = retime(data(:,'VolumeBTC'),'regular','sum','TimeStep',Duration);
Data = [Open,High,Low,Close,Vol];
Data=rmmissing(Data);
