function [fileName,filePath,headerlines,scalingFactor,selectedScaling,selectedLoadCase,w,W,time,scaling,Unit] = page1(fileName,filePath,headerlines,scalingFactor,selectedScaling,selectedLoadCase)

file = [filePath,fileName];

set(figure(10),'Visible','off');
helpString1 = text('tag','helpString1','string',{'請選擇地震歷時：請在文字區塊輸入地震歷時檔名或按預覽選擇地震歷時，單位(gal)。';
    '忽略開頭文字列數：將歷時中非歷時數字之文字列數略過。';
    '歷時單位：請選擇輸入歷時之單位，計算時將轉換單位為 cm/sec^2 計算(轉換後儲存為原單位)。';
    '請選擇歷時方向：請選擇進行轉換之歷時方向。如歷時檔僅有 [時間  加速度]，請選擇"僅有一組"。           .';
    '';
    ' * 如歷時單位不為 cm/sec^2 或 m/sec^2，請使用 Scaling Factor 調整至 cm/sec^2。';
    ' * 氣象局地震歷時格式為 [時間  垂直向加速度  南北向加速度  東西向加速度]。';
    ' * 時間行之第一筆與第二筆數據差將會用來設定時間間距。';
    ' * 轉換規定依100年之建築物耐震設計規範。';
    '';
    'This program preserve by NTU CE-912, Aug. 2013。';
    '';
    '按下OK後可在Figure(2)檢查輸入之歷時。';});

page1Continue = 0;
while (page1Continue == 0)
    fig1 = figure(1);
    set(fig1,'Resize','off');
    headText = uicontrol(fig1,'Style','text','String','設計反應譜相符之人造地震記錄 v0.9','FontSize',15,'Position',[80 385 420 30],'BackgroundColor',[0.8 0.8 0.8]);
    loadText = uicontrol(fig1,'Style','text','String','請選擇地震歷時','FontSize',14,'Position',[180 350 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    loadTextEdit =uicontrol(fig1,'Style','edit','tag','loadTextEdit','String',file,'FontSize',14,'Position',[100 320 300 26]);
    loadDirButton = uicontrol(fig1,'Style','pushbutton','String','預覽','FontSize',14,'Position',[410 320 50 26],'Callback','[fileName filePath] = uigetfile(''*.txt'',''Select Input file of eqrthquake record''),if fileName == 0; fileName = '' ''; end,if filePath == 0; filePath = pwd; end, h1 = findobj(''tag'',''loadTextEdit''), set(h1,''String'', [filePath fileName])');
    
    headerlinesText = uicontrol(fig1,'Style','text','String','忽略開頭文字列數','FontSize',14,'Position',[200 280 150 26],'BackgroundColor',[0.8 0.8 0.8]);
    headerlinesEdit = uicontrol(fig1,'Style','edit','String',headerlines,'FontSize',14,'Position',[240 250 72 26]);
    
    scalingText = uicontrol(fig1,'Style','text','String','歷時單位：','FontSize',14,'Position',[50 213 150 26],'BackgroundColor',[0.8 0.8 0.8]);
    scalingRadioButtonGroup = uibuttongroup(fig1,'visible','off','BackgroundColor',[0.8 0.8 0.8]);
    scalingCase1 = uicontrol('Style','Radio','tag','off','String','cm/sec','FontSize',14,'Position',[170 210 150 30],'Parent',scalingRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    cm_sub_2_text = uicontrol(fig1,'Style','text','String','2','FontSize',8,'Position',[250 230 8 10],'BackgroundColor',[0.8 0.8 0.8]);
    scalingCase2 = uicontrol('Style','Radio','tag','off','String','m/sec','FontSize',14,'Position',[320 210 150 30],'Parent',scalingRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    m_sub_2_text = uicontrol(fig1,'Style','text','String','2','FontSize',8,'Position',[390 230 8 10],'BackgroundColor',[0.8 0.8 0.8]);
    scalingCase3 = uicontrol('Style','Radio','tag','on','String','自行設定Scaling factor','FontSize',14,'Position',[170 180 225 30],'Parent',scalingRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    scalingEdit = uicontrol(fig1,'Style','edit','tag','scalingEdit','String',scalingFactor,'FontSize',14,'Position',[390 183 72 26],'Visible','off');
    if selectedScaling == 1
        set(scalingRadioButtonGroup,'SelectedObject',scalingCase1);
    elseif selectedScaling == 2
        set(scalingRadioButtonGroup,'SelectedObject',scalingCase2);
    elseif selectedScaling == 3
        set(scalingRadioButtonGroup,'SelectedObject',scalingCase3);
        set(scalingEdit,'Visible','on');
    end
    set(scalingRadioButtonGroup,'Visible','on');
    set(scalingRadioButtonGroup,'SelectionChangeFcn',@(source,eventdata) set(findobj('tag','scalingEdit'),'Visible',get(eventdata.NewValue,'tag')) );
    
    loadCaseRadioButtonGroup = uibuttongroup(fig1,'visible','off','BackgroundColor',[0.8 0.8 0.8]);
    loadCaseText = uicontrol('Style','text','String','請選擇歷時方向','FontSize',14,'Position',[180 140 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    loadCase1 = uicontrol('Style','Radio','String','垂直向(U+)','FontSize',14,'Position',[70 110 150 30],'Parent',loadCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    loadCase2 = uicontrol('Style','Radio','String','南北向(N+)','FontSize',14,'Position',[220 110 150 30],'Parent',loadCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    loadCase3 = uicontrol('Style','Radio','String','東西向(E+)','FontSize',14,'Position',[370 110 150 30],'Parent',loadCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    loadCase4 = uicontrol('Style','Radio','String','僅有一組','FontSize',14,'Position',[220 80 150 30],'Parent',loadCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    if selectedLoadCase == 1;
        set(loadCaseRadioButtonGroup,'SelectedObject',loadCase1);
    elseif selectedLoadCase == 2;
        set(loadCaseRadioButtonGroup,'SelectedObject',loadCase2);
    elseif selectedLoadCase == 3;
        set(loadCaseRadioButtonGroup,'SelectedObject',loadCase3);
    elseif selectedLoadCase == 4;
        set(loadCaseRadioButtonGroup,'SelectedObject',loadCase4);
    else
        set(loadCaseRadioButtonGroup,'SelectedObject',[]);
    end
    set(loadCaseRadioButtonGroup,'Visible','on');
    
    okButton = uicontrol(fig1,'Style','pushbutton','String','OK','FontSize',14,'Position',[230 30 100 40],'Callback','uiresume(gcf)');
    helpButton = uicontrol(fig1,'Style','pushbutton','String','HELP','FontSize',10,'Position',[500 20 40 25],'Callback','help1 = findobj(''tag'',''helpString1''), msgbox(get(help1,''String''),''HELP'',''help''), set(findobj(''tag'',''ha''),''Value'',get(findobj(''tag'',''ha''),''Value'')+1),if get(findobj(''tag'',''ha''),''Value'')>=10;set(findobj(''tag'',''ha''),''Visible'',''on'');end');
    helloButton = uicontrol(fig1,'Style','pushbutton','tag','ha','Value',0,'String','HELLO!','FontSize',10,'Visible','off','Position',[20 20 55 25],'Callback','msgbox(''Hello, I am the author Y.A. Lai. Thanks for using this program!'',''HELP'',''help'')');
    
    uiwait(fig1);
    selectedLoadCaseRadioButton = get(get(loadCaseRadioButtonGroup,'SelectedObject'),'String');
    headerlines = str2double(get(headerlinesEdit,'String'));
    file = get(loadTextEdit,'String');
    index = findstr(file,'\');
    filePath = file(1:index(end));
    fileName = file(index(end)+1:end);
    selectedScalingRadioButton = get(get(scalingRadioButtonGroup,'SelectedObject'),'String');
    scalingFactor = get(scalingEdit,'String');
    
    close(fig1);

    try
        switch selectedScalingRadioButton
            case 'cm/sec'
                selectedScaling = 1;
                scaling = 'cm/sec^2';
                scalingFactor = 1.0;
                Unit = 'cm/sec^2';
                
            case 'm/sec'
                selectedScaling = 2;
                scaling = 'm/sec^2';
                scalingFactor = 100;
                Unit = 'm/sec^2';
                
            case '自行設定Scaling factor'
                selectedScaling = 3;
                scaling = ['Scaling factor:' scalingFactor];
                scalingFactor = str2double(scalingFactor);
                Unit = '';
        end
        
        switch selectedLoadCaseRadioButton
            case '垂直向(U+)'
                selectedLoadCase = 1;
                [time records_U records_N records_E]=textread(file,'%f %f %f %f','headerlines',headerlines);
                w = records_U;
                W = records_U;
            case '南北向(N+)'
                selectedLoadCase = 2;
                [time records_U records_N records_E]=textread(file,'%f %f %f %f','headerlines',headerlines);
                w = records_N;
                W = records_N;
            case '東西向(E+)'
                selectedLoadCase = 3;
                [time records_U records_N records_E]=textread(file,'%f %f %f %f','headerlines',headerlines);
                w = records_E;
                W = records_E;
            case '僅有一組'
                selectedLoadCase = 4;
                [time records]=textread(file,'%f %f','headerlines',headerlines);
                w = records;
                W = records;
        end
        
        if isnan(scalingFactor)
            errorMessageBox = msgbox('Scaling factor錯誤','ERROR!','error');
            uiwait(errorMessageBox);
        elseif scalingFactor < 0
            errorMessageBox = msgbox('Scaling factor錯誤','ERROR!','error');
            uiwait(errorMessageBox);
        else
            w = w*scalingFactor;
            W = W*scalingFactor;
            page1Continue = 1;
        end
        
    catch
        errorinformation = lasterror;
        if strcmp(errorinformation.identifier,'MATLAB:dataread:TroubleReading')
            errorMessageBox = msgbox('忽略開頭文字列數錯誤','ERROR!','error');
            uiwait(errorMessageBox);
        elseif strcmp(errorinformation.identifier,'MATLAB:dataread:InvalidHeaderlineValue')
            errorMessageBox = msgbox('忽略開頭文字列數錯誤','ERROR!','error');
            uiwait(errorMessageBox);
        elseif strcmp(errorinformation.identifier,'MATLAB:badSwitchExpression')
            errorMessageBox = msgbox('請重新選擇歷時方向','ERROR!','error');
            uiwait(errorMessageBox);
        elseif strcmp(errorinformation.identifier,'')
            errorMessageBox = msgbox('請重新選擇歷時','ERROR!','error');
            uiwait(errorMessageBox);
        end
    end
    
    scalingFactor = num2str(scalingFactor);
    headerlines = num2str(headerlines);
end

close(figure(10));