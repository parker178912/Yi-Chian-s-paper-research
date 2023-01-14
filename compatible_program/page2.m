function [structuralPeriod,structuralDamping,lowBound,highBound,highFix,maxIter,iterRatio,timeStep,locationCheck,isolatedCheck,prePage] = page2(structuralPeriod,structuralDamping,lowBound,highBound,highFix,maxIter,iterRatio,timeStep,locationCheck,isolatedCheck)

prePage = 0;
set(figure(10),'Visible','off');
helpString2 = text('tag','helpString2','string',{'�п�J���c�g���G�Цb��r�϶���J�u�}���c���g���A���(sec)�C';
    '�п�J���c������G�Цb��r�϶�����J�u�}���c��������ȡC';
    '�O�_�֦a�G�Ŀ�x�_�֦a�h�U�����]�p�����Щγ̤j�Ҷq�����жȻݿ��T0D��T0M�C';
    '�j�_���c�G�Ŀ�j�_���c�h�����Ъ��g������0.4SDS��0.4SMS������C';
    '�����жg���վ�d��G�W�d���ɤ����Цb���c�g����0.2��[�U��]~1.5��[�W��]���ݻP�]�p(�̤j�Ҷq)�����Ь۲šC';
    '�����нվ�W�����v�G�W�d�õL�W�����W�w�A�i�ۦ�]�w�A��ĳ���C��1.1���C';
    '�̤j���N���ơG�]�w���N�̤j���ơA��F�����ơA�L�צ��L�F��۲ű���A�ҷ|����N�C';
    '�ץ����v�G�]�w���N�ץ��ɤ����v(S)�A�]�w�Ȭ�0~1�A��ĳ�Ȭ�0.5�H���A�p���N�L�{�����ġA�i���ձN���Ƚդp�C           .';
    '���ɨ��˶��Z(sec)�G�]�w���ɨ��ˮɶ����Z�A���ˮɶ����Z�V�j�A�h�p��q�V�֡A��ĳ���W�L0.02�C';
    '';
    '���UOK��i�bFigure(3)�ˬd���ˤ����ɡC'});
prePageText = text('tag','prePage','string','0');

page2Continue = 0;
while (page2Continue == 0)
    fig1 = figure(1);
    set(fig1,'Resize','off');
    sructuralPeriodText = uicontrol(fig1,'Style','text','String','�п�J���c�g��(sec)','FontSize',14,'Position',[120 350 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    structuralPeriodEdit = uicontrol(fig1,'Style','edit','String',structuralPeriod,'FontSize',14,'Position',[315 350 100 26]);
    
    structuralDampingText = uicontrol(fig1,'Style','text','String','�п�J���c������','FontSize',14,'Position',[130 320 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    structuralDampingEdit = uicontrol(fig1,'Style','edit','String',structuralDamping,'FontSize',14,'Position',[315 320 100 26]);
    
    locationCheckBox = uicontrol(fig1,'Style','checkbox','String','�O�_�֦a','FontSize',14,'Position',[320 290 100 28],'BackgroundColor',[0.8 0.8 0.8]);
    set(locationCheckBox,'Value',locationCheck);
    isolatedCheckBox = uicontrol(fig1,'Style','checkbox','String','�j�_���c','FontSize',14,'Position',[320 260 100 28],'BackgroundColor',[0.8 0.8 0.8]);
    set(isolatedCheckBox,'Value',isolatedCheck);
    
    lowBoundText = uicontrol(fig1,'Style','text','String','�����жg���վ�d��(�U��)','FontSize',12,'Position',[115 230 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    lowBoundEdit = uicontrol(fig1,'Style','edit','String',lowBound,'FontSize',14,'Position',[315 230 80 26]);
    
    highBoundText = uicontrol(fig1,'Style','text','String','�����жg���վ�d��(�W��)','FontSize',12,'Position',[115 200 200 26],'BackgroundColor',[0.8 0.8 0.8]);
    highBoundEdit = uicontrol(fig1,'Style','edit','String',highBound,'FontSize',14,'Position',[315 200 80 26]);
    
    highFixText = uicontrol(fig1,'Style','text','String','�����нվ�W�����v','FontSize',12,'Position',[120 170 230 26],'BackgroundColor',[0.8 0.8 0.8]);
    highFixEdit = uicontrol(fig1,'Style','edit','String',highFix,'FontSize',14,'Position',[315 170 80 26]);
    
    maxIterText = uicontrol(fig1,'Style','text','String','�̤j���N����','FontSize',12,'Position',[205 140 100 26],'BackgroundColor',[0.8 0.8 0.8]);
    maxIterEdit = uicontrol(fig1,'Style','edit','String',maxIter,'FontSize',14,'Position',[315 140 80 26]);
    
    iterRatioText = uicontrol(fig1,'Style','text','String','�ץ����v','FontSize',12,'Position',[220 110 100 26],'BackgroundColor',[0.8 0.8 0.8]);
    iterRatioEdit = uicontrol(fig1,'Style','edit','String',iterRatio,'FontSize',14,'Position',[315 110 80 26]);
    
    timeStepText = uicontrol(fig1,'Style','text','String','���ɨ��˶��Z(sec)','FontSize',12,'Position',[165 80 150 26],'BackgroundColor',[0.8 0.8 0.8]);
    timeStepEdit = uicontrol(fig1,'Style','edit','String',timeStep,'FontSize',14,'Position',[315 80 80 26]);
    
    okButton = uicontrol(fig1,'Style','pushbutton','String','OK','FontSize',14,'Position',[230 30 100 40],'Callback','uiresume()');
    helpButton = uicontrol(fig1,'Style','pushbutton','String','HELP','FontSize',10,'Position',[500 20 40 25],'Callback','help2 = findobj(''tag'',''helpString2''), msgbox(get(help2,''String''),''HELP'',''help'')');
    prePageButton = uicontrol(fig1,'Style','pushbutton','String','��','FontSize',12,'Position',[20 20 40 25],'Callback','set(findobj(''tag'',''prePage''),''string'',''1'') ; uiresume()');
    
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
        errorMessageBox = msgbox('���c�g�����~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(structuralPeriod) <= 0
        errorMessageBox = msgbox('���c�g�����~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(structuralDamping))
        errorMessageBox = msgbox('���c��������~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(structuralDamping) < 0
        errorMessageBox = msgbox('���c��������~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(lowBound))
        errorMessageBox = msgbox('�����жg���վ�U�����~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(lowBound) <= 0
        errorMessageBox = msgbox('�����жg���վ�U�����~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(highBound))
        errorMessageBox = msgbox('�����жg���վ�W�����~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(highBound) <= 0
        errorMessageBox = msgbox('�����жg���վ�W�����~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(lowBound) >= str2double(highBound)
        errorMessageBox = msgbox('�����жg���վ�d����~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(highFix))
        errorMessageBox = msgbox('�����нվ�W�����v���~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(highFix) < 0.9
        errorMessageBox = msgbox('�����нվ�W�����v���~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(maxIter))
        errorMessageBox = msgbox('�̤j���N���ƿ��~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(maxIter) <= 0
        errorMessageBox = msgbox('�̤j���N���ƿ��~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(iterRatio))
        errorMessageBox = msgbox('�ץ����v���~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(iterRatio) <= 0
        errorMessageBox = msgbox('�ץ����v���~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(iterRatio) >= 1
        errorMessageBox = msgbox('�ץ����v���~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif isnan(str2double(timeStep))
        errorMessageBox = msgbox('���ɨ��˶��Z���~','ERROR!','error');
        uiwait(errorMessageBox);
    elseif str2double(timeStep) <= 0
        errorMessageBox = msgbox('���ɨ��˶��Z���~','ERROR!','error');
        uiwait(errorMessageBox);
    else
        page2Continue = 1;
    end
    
    if str2double(lowBound) > 0.2
        warnMessageBox = msgbox('�W�d�]�w�g���վ�U����0.2!','WARNING!','warn');
        uiwait(warnMessageBox);
    end
    if str2double(highBound) < 1.5
        warnMessageBox = msgbox('�W�d�]�w�g���վ�U����1.5!','WARNING!','warn');
        uiwait(warnMessageBox);
    end
end

close(figure(10));