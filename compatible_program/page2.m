function [structuralPeriod,structuralDamping,lowBound,highBound,highFix,maxIter,iterRatio,timeStep,locationCheck,isolatedCheck,prePage] = page2(structuralPeriod,structuralDamping,lowBound,highBound,highFix,maxIter,iterRatio,timeStep,locationCheck,isolatedCheck)

prePage = 0;
set(figure(10),'Visible','off');
helpString2 = text('tag','helpString2','string',{'請輸入結構週期：請在文字區塊輸入工址結構之週期，單位(sec)。';
    '請輸入結構阻尼比：請在文字區塊中輸入工址結構之阻尼比值。';
    '臺北盆地：勾選台北盆地則下頁之設計反應譜或最大考量反應譜僅需選取T0D或T0M。';
    '隔震結構：勾選隔震結構則反應譜長週期不受0.4SDS或0.4SMS之限制。';
    '反應譜週期調整範圍：規範歷時反應譜在結構週期之0.2倍[下限]~1.5倍[上限]間需與設計(最大考量)反應譜相符。';
    '反應譜調整上限倍率：規範並無上限之規定，可自行設定，建議不低於1.1倍。';
    '最大迭代次數：設定迭代最大次數，到達此次數，無論有無達到相符條件，皆會停止迭代。';
    '修正倍率：設定迭代修正時之倍率(S)，設定值為0~1，建議值為0.5以內，如迭代過程不收斂，可嘗試將此值調小。           .';
    '歷時取樣間距(sec)：設定歷時取樣時間間距，取樣時間間距越大，則計算量越少，建議不超過0.02。';
    '';
    '按下OK後可在Figure(3)檢查取樣之歷時。'});
prePageText = text('tag','prePage','string','0');

page2Continue = 0;
while (page2Continue == 0)
    fig1 = figure(1);
    set(fig1,'Resize','off');
    sructuralPeriodText = uicontrol(fig1,'Style','text','String','請輸入結構週期(sec)','FontSize',14,'Position',[120 350 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    structuralPeriodEdit = uicontrol(fig1,'Style','edit','String',structuralPeriod,'FontSize',14,'Position',[315 350 100 26]);
    
    structuralDampingText = uicontrol(fig1,'Style','text','String','請輸入結構阻尼比','FontSize',14,'Position',[130 320 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    structuralDampingEdit = uicontrol(fig1,'Style','edit','String',structuralDamping,'FontSize',14,'Position',[315 320 100 26]);
    
    locationCheckBox = uicontrol(fig1,'Style','checkbox','String','臺北盆地','FontSize',14,'Position',[320 290 100 28],'BackgroundColor',[0.8 0.8 0.8]);
    set(locationCheckBox,'Value',locationCheck);
    isolatedCheckBox = uicontrol(fig1,'Style','checkbox','String','隔震結構','FontSize',14,'Position',[320 260 100 28],'BackgroundColor',[0.8 0.8 0.8]);
    set(isolatedCheckBox,'Value',isolatedCheck);
    
    lowBoundText = uicontrol(fig1,'Style','text','String','反應譜週期調整範圍(下限)','FontSize',12,'Position',[115 230 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    lowBoundEdit = uicontrol(fig1,'Style','edit','String',lowBound,'FontSize',14,'Position',[315 230 80 26]);
    
    highBoundText = uicontrol(fig1,'Style','text','String','反應譜週期調整範圍(上限)','FontSize',12,'Position',[115 200 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    highBoundEdit = uicontrol(fig1,'Style','edit','String',highBound,'FontSize',14,'Position',[315 200 80 26]);
    
    highFixText = uicontrol(fig1,'Style','text','String','反應譜調整上限倍率','FontSize',12,'Position',[120 170 230 26],'BackgroundColor',[0.8 0.8 0.8]);
    highFixEdit = uicontrol(fig1,'Style','edit','String',highFix,'FontSize',14,'Position',[315 170 80 26]);
    
    maxIterText = uicontrol(fig1,'Style','text','String','最大迭代次數','FontSize',12,'Position',[205 140 100 26],'BackgroundColor',[0.8 0.8 0.8]);
    maxIterEdit = uicontrol(fig1,'Style','edit','String',maxIter,'FontSize',14,'Position',[315 140 80 26]);
    
    iterRatioText = uicontrol(fig1,'Style','text','String','修正倍率','FontSize',12,'Position',[220 110 100 26],'BackgroundColor',[0.8 0.8 0.8]);
    iterRatioEdit = uicontrol(fig1,'Style','edit','String',iterRatio,'FontSize',14,'Position',[315 110 80 26]);
    
    timeStepText = uicontrol(fig1,'Style','text','String','歷時取樣間距(sec)','FontSize',12,'Position',[165 80 150 26],'BackgroundColor',[0.8 0.8 0.8]);
    timeStepEdit = uicontrol(fig1,'Style','edit','String',timeStep,'FontSize',14,'Position',[315 80 80 26]);
    
    okButton = uicontrol(fig1,'Style','pushbutton','String','OK','FontSize',14,'Position',[230 30 100 40],'Callback','uiresume()');
    helpButton = uicontrol(fig1,'Style','pushbutton','String','HELP','FontSize',10,'Position',[500 20 40 25],'Callback','help2 = findobj(''tag'',''helpString2''), msgbox(get(help2,''String''),''HELP'',''help'')');
    prePageButton = uicontrol(fig1,'Style','pushbutton','String','←','FontSize',12,'Position',[20 20 40 25],'Callback','set(findobj(''tag'',''prePage''),''string'',''1'') ; uiresume()');
    
    uiwait(fig1)
    structuralPeriod = get(structuralPeriodEdit,'String');
    structuralDamping = get(structuralDampingEdit,'String');
    locationCheck = get(locationCheckBox,'Value');
    isolatedCheck = get(isolatedCheckBox,'Value');
    lowBound = get(lowBoundEdit,'String');
    highBound = get(highBoundEdit,'String');
    highFix = get(highFixEdit,'String');
    maxIter = get(maxIterEdit,'String');
    iterRatio = get(iterRatioEdit,'String');
    timeStep = get(timeStepEdit,'String');
    
    close(fig1);
    if str2double(get(findobj('tag','prePage'),'string')) == 1
        prePage = 1;
        return
    end
    
    if isnan(str2double(structuralPeriod))
        errorMessageBox = msgbox('結構週期錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(structuralPeriod) <= 0
        errorMessageBox = msgbox('結構週期錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(structuralDamping))
        errorMessageBox = msgbox('結構阻尼比錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(structuralDamping) < 0
        errorMessageBox = msgbox('結構阻尼比錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(lowBound))
        errorMessageBox = msgbox('反應譜週期調整下限錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(lowBound) <= 0
        errorMessageBox = msgbox('反應譜週期調整下限錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(highBound))
        errorMessageBox = msgbox('反應譜週期調整上限錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(highBound) <= 0
        errorMessageBox = msgbox('反應譜週期調整上限錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(lowBound) >= str2double(highBound)
        errorMessageBox = msgbox('反應譜週期調整範圍錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(highFix))
        errorMessageBox = msgbox('反應譜調整上限倍率錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(highFix) < 0.9
        errorMessageBox = msgbox('反應譜調整上限倍率錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(maxIter))
        errorMessageBox = msgbox('最大迭代次數錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(maxIter) <= 0
        errorMessageBox = msgbox('最大迭代次數錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(iterRatio))
        errorMessageBox = msgbox('修正倍率錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(iterRatio) <= 0
        errorMessageBox = msgbox('修正倍率錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(iterRatio) >= 1
        errorMessageBox = msgbox('修正倍率錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(timeStep))
        errorMessageBox = msgbox('歷時取樣間距錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(timeStep) <= 0
        errorMessageBox = msgbox('歷時取樣間距錯誤','ERROR!','error');
        uiwait(errorMessageBox);
    else
        page2Continue = 1;
    end
    
    if str2double(lowBound) > 0.2
        warnMessageBox = msgbox('規範設定週期調整下限為0.2!','WARNING!','warn');
        uiwait(warnMessageBox);
    end
    if str2double(highBound) < 1.5
        warnMessageBox = msgbox('規範設定週期調整下限為1.5!','WARNING!','warn');
        uiwait(warnMessageBox);
    end
end

close(figure(10));