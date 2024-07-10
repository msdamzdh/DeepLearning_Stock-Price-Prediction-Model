function [] = plotSeries(predict_val,real_val)

subplot(2,1,1)
    hold on
    plot(1:numel(predict_val),predict_val,'r');
    plot(1:numel(real_val),real_val,'b');
    legend(["Predict","Real"])
    hold off
subplot(2,1,2)
    plot(1:numel(real_val),100*abs(predict_val-real_val)./real_val);
end