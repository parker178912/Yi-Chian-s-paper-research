function [fileName,filePath,headerlines,scalingFactor,selectedScaling,selectedLoadCase,w,W,time,scaling,Unit] = page1(fileName,filePath,headerlines,scalingFactor,selectedScaling,selectedLoadCase)

file = [filePath,fileName];

set(figure(10),'Visible','off');
helpString1 = text('tag','helpString1','string',{'�п�ܦa�_���ɡG�Цb��r�϶���J�a�_�����ɦW�Ϋ��w����ܦa�_���ɡA���(gal)�C';
    '�����}�Y��r�C�ơG�N���ɤ��D���ɼƦr����r�C�Ʋ��L�C';
    '���ɳ��G�п�ܿ�J���ɤ����A�p��ɱN�ഫ��쬰 cm/sec^2 �p��(�ഫ���x�s������)�C';
    '�п�ܾ��ɤ�V�G�п�ܶi���ഫ�����ɤ�V�C�p�����ɶȦ� [�ɶ�  �[�t��]�A�п��"�Ȧ��@��"�C           .';
    '';
    ' * �p���ɳ�줣�� cm/sec^2 �� m/sec^2�A�Шϥ� Scaling Factor �վ�� cm/sec^2�C';
    ' * ��H���a�_���ɮ榡�� [�ɶ�  �����V�[�t��  �n�_�V�[�t��  �F��V�[�t��]�C';
    ' * �ɶ��椧�Ĥ@���P�ĤG���ƾڮt�N�|�Ψӳ]�w�ɶ����Z�C';
    ' * �ഫ�W�w��100�~���ؿv���@�_�]�p�W�d�C';
    '';
    'This program preserve by NTU CE-912, Aug. 2013�C';
    '';
    '���UOK��i�bFigure(2)�ˬd��J�����ɡC';});

page1Continue = 0;
while (page1Continue == 0)
    fig1 = figure(1);
    set(fig1,'Resize','off');
    headText = uicontrol(fig1,'Style','text','String','�]�p�����Ь۲Ť��H�y�a�_�O�� v0.9','FontSize',15,'Position',[80 385 420 30],'BackgroundColor',[0.8 0.8 0.8]);
    loadText = uicontrol(fig1,'Style','text','String','�п�ܦa�_����','FontSize',14,'Position',[180 350 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    loadTextEdit =uicontrol(fig1,'Style','edit','tag','loadTextEdit','String',file,'FontSize',14,'Position',[100 320 300 26]);
    loadDirButton = uicontrol(fig1,'Style','pushbutton','String','�w��','FontSize',14,'Position',[410 320 50 26],'Callback','[fileName filePath] = uigetfile(''*.txt'',''Select Input file of eqrthquake record''),if fileName == 0; fileName = '' ''; end,if filePath == 0; filePath = pwd; end, h1 = findobj(''tag'',''loadTextEdit''), set(h1,''String'', [filePath fileName])');
    
    headerlinesText = uicontrol(fig1,'Style','text','String','�����}�Y��r�C��','FontSize',14,'Position',[200 280 150 26],'BackgroundColor',[0.8 0.8 0.8]);
    headerlinesEdit = uicontrol(fig1,'Style','edit','String',headerlines,'FontSize',14,'Position',[240 250 72 26]);
    
    scalingText = uicontrol(fig1,'Style','text','String','���ɳ��G','FontSize',14,'Position',[50 213 150 26],'BackgroundColor',[0.8 0.8 0.8]);
    scalingRadioButtonGroup = uibuttongroup(fig1,'visible','off','BackgroundColor',[0.8 0.8 0.8]);
    scalingCase1 = uicontrol('Style','Radio','tag','off','String','cm/sec','FontSize',14,'Position',[170 210 150 30],'Parent',scalingRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    cm_sub_2_text = uicontrol(fig1,'Style','text','String','2','FontSize',8,'Position',[250 230 8 10],'BackgroundColor',[0.8 0.8 0.8]);
    scalingCase2 = uicontrol('Style','Radio','tag','off','String','m/sec','FontSize',14,'Position',[320 210 150 30],'Parent',scalingRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    m_sub_2_text = uicontrol(fig1,'Style','text','String','2','FontSize',8,'Position',[390 230 8 10],'BackgroundColor',[0.8 0.8 0.8]);
    scalingCase3 = uicontrol('Style','Radio','tag','on','String','�ۦ�]�wScaling factor','FontSize',14,'Position',[170 180 225 30],'Parent',scalingRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
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
    loadCaseText = uicontrol('Style','text','String','�п�ܾ��ɤ�V','FontSize',14,'Position',[180 140 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    loadCase1 = uicontrol('Style','Radio','String','�����V(U+)','FontSize',14,'Position',[70 110 150 30],'Parent',loadCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    loadCase2 = uicontrol('Style','Radio','String','�n�_�V(N+)','FontSize',14,'Position',[220 110 150 30],'Parent',loadCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    loadCase3 = uicontrol('Style','Radio','String','�F��V(E+)','FontSize',14,'Position',[370 110 150 30],'Parent',loadCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
    loadCase4 = uicontrol('Style','Radio','String','�Ȧ��@��','FontSize',14,'Position',[220 80 150 30],'Parent',loadCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
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
                
            case '�ۦ�]�wScaling factor'
                selectedScaling = 3;
                scaling = ['Scaling factor:' scalingFactor];
                scalingFactor = str2double(scalingFactor);
                Unit = '';
        end
        
        switch selectedLoadCaseRadioButton
            case '�����V(U+)'
                selectedLoadCase = 1;
                [time records_U records_N records_E]=textread(file,'%f %f %f %f','headerlines',headerlines);
                w = records_U;
                W = records_U;
            case '�n�_�V(N+)'
                selectedLoadCase = 2;
                [time records_U records_N records_E]=textread(file,'%f %f %f %f','headerlines',headerlines);
                w = records_N;
                W = records_N;
            case '�F��V(E+)'
                selectedLoadCase = 3;
                [time records_U records_N records_E]=textread(file,'%f %f %f %f','headerlines',headerlines);
                w = records_E;
                W = records_E;
            case '�Ȧ��@��'
                selectedLoadCase = 4;
                [time records]=textread(file,'%f %f','headerlines',headerlines);
                w = records;
                W = records;
        end
        
        if isnan(scalingFactor)
            errorMessageBox = msgbox('Scaling factor���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif scalingFactor < 0
            errorMessageBox = msgbox('Scaling factor���~','ERROR!','error');
            uiwait(errorMessageBox);
        else
            w = w*scalingFactor;
            W = W*scalingFactor;
            page1Continue = 1;
        end
        
    catch
        errorinformation = lasterror;
        if strcmp(errorinformation.identifier,'MATLAB:dataread:TroubleReading')
            errorMessageBox = msgbox('�����}�Y��r�C�ƿ��~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif strcmp(errorinformation.identifier,'MATLAB:dataread:InvalidHeaderlineValue')
            errorMessageBox = msgbox('�����}�Y��r�C�ƿ��~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif strcmp(errorinformation.identifier,'MATLAB:badSwitchExpression')
            errorMessageBox = msgbox('�Э��s��ܾ��ɤ�V','ERROR!','error');
            uiwait(errorMessageBox);
        elseif strcmp(errorinformation.identifier,'')
            errorMessageBox = msgbox('�Э��s��ܾ���','ERROR!','error');
            uiwait(errorMessageBox);
        end
    end
    
    scalingFactor = num2str(scalingFactor);
    headerlines = num2str(headerlines);
end

close(figure(10));