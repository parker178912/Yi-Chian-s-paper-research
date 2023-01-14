function [considerCase,S_DS,T0D,selected_area,prePage] = page4(considerCase,T0D)

prePage = 0;
set(figure(10),'Visible','off');
helpString4 = text('tag','helpString4','string',{'�Ш̤u�}��ܻO�_�֦a���L���ϡC';
    '';
	'���UOK��i�qFigure(4)�ˬd�]�p�����СC'});
helpString4_2 = text('tag','helpString4_2','string',{'�Ш̤u�}��ܻO�_�֦a���L���ϡC';
    '';
	'���UOK��i�qFigure(4)�ˬd�̤j�Ҷq�����СC'});
prePageText = text('tag','prePage','string','0');

page4Continue = 0;
while (page4Continue == 0)
	if considerCase == 1
        S_DS = 0.6;
        fig1 = figure(1);
        set(fig1,'Resize','off');
        
        taipeiRadioButtonGroup = uibuttongroup(fig1,'visible','off','BackgroundColor',[0.8 0.8 0.8]);
        tap_design_spectrum_text = uicontrol('Style','text','String','�п�ܻO�_�֦a�]�p�����Э�','FontSize',14,'Position',[160 350 250 26],'Parent',taipeiRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8]);
        
        considerCaseRadioButtonGroup = uibuttongroup(fig1,'visible','off','BackgroundColor',[0.8 0.8 0.8]);
        considerCase1 = uicontrol('Style','Radio','String','�]�p�a�_������','FontSize',14,'Position',[100 310 200 30],'Parent',considerCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
        considerCase2 = uicontrol('Style','Radio','String','�̤j�Ҷq�a�_������','FontSize',14,'Position',[300 310 200 30],'Parent',considerCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
        set(considerCaseRadioButtonGroup,'SelectedObject',considerCase1);
        set(considerCaseRadioButtonGroup,'Visible','on');
        set(considerCaseRadioButtonGroup,'SelectionChangeFcn',@(source,eventdata) uiresume() );
        
        tap1 = uicontrol('Style','Radio','String','�O�_�@��(�ਤ�g�� = 1.6 sec)','FontSize',14,'Position',[150 250 300 30],'Parent',taipeiRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8]);
        tap2 = uicontrol('Style','Radio','String','�O�_�G��(�ਤ�g�� = 1.3 sec)','FontSize',14,'Position',[150 210 300 30],'Parent',taipeiRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8]);
        tap3 = uicontrol('Style','Radio','String','�O�_�T��(�ਤ�g�� = 1.05 sec)','FontSize',14,'Position',[150 170 300 30],'Parent',taipeiRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8]);
        
        ok_button = uicontrol('Style','pushbutton','String','OK','FontSize',14,'Position',[230 60 100 40],'Callback','uiresume()');
        helpButton = uicontrol(fig1,'Style','pushbutton','String','HELP','FontSize',10,'Position',[500 20 40 25],'Callback','help4 = findobj(''tag'',''helpString4''), msgbox(get(help4,''String''),''HELP'',''help'')');
        prePageButton = uicontrol(fig1,'Style','pushbutton','String','��','FontSize',14,'Position',[20 20 40 25],'Callback','set(findobj(''tag'',''prePage''),''string'',''1'') ; uiresume()');
        
        if T0D == 1.6;
            set(taipeiRadioButtonGroup,'SelectedObject',tap1);
        elseif T0D == 1.3;
            set(taipeiRadioButtonGroup,'SelectedObject',tap2);
        elseif T0D == 1.05;
            set(taipeiRadioButtonGroup,'SelectedObject',tap3);
        else
            set(taipeiRadioButtonGroup,'SelectedObject',[]);
        end
        set(taipeiRadioButtonGroup,'Visible','on');
        uiwait(fig1)
        
        selectedConsiderCaseRadioButton = get(get(considerCaseRadioButtonGroup,'SelectedObject'),'String');
        selected_area = get(get(taipeiRadioButtonGroup,'SelectedObject'),'String');
        close(fig1);
        
        try
            switch selected_area
                case '�O�_�@��(�ਤ�g�� = 1.6 sec)'
                    T0D = 1.6;
                case '�O�_�G��(�ਤ�g�� = 1.3 sec)'
                    T0D = 1.3;
                case '�O�_�T��(�ਤ�g�� = 1.05 sec)'
                    T0D = 1.05;
            end
        end
        
        if str2double(get(findobj('tag','prePage'),'string')) == 1
            prePage = 1;
            return
        end
        
        switch selectedConsiderCaseRadioButton
            case '�]�p�a�_������'
                if considerCase == 2
                    considerCase = 1;
                    continue
                end
            case '�̤j�Ҷq�a�_������'
                if considerCase == 1
                    considerCase = 2;
                    continue
                end
        end
    else
        S_DS = 0.8;
        fig1 = figure(1);
        set(fig1,'Resize','off');
        
        taipeiRadioButtonGroup = uibuttongroup(fig1,'visible','off','BackgroundColor',[0.8 0.8 0.8]);
        tap_design_spectrum_text = uicontrol('Style','text','String','�п�ܻO�_�֦a�̤j�Ҷq�����Э�','FontSize',14,'Position',[140 350 300 26],'Parent',taipeiRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8]);
        
        considerCaseRadioButtonGroup = uibuttongroup(fig1,'visible','off','BackgroundColor',[0.8 0.8 0.8]);
        considerCase1 = uicontrol('Style','Radio','String','�]�p�a�_������','FontSize',14,'Position',[100 310 200 30],'Parent',considerCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
        considerCase2 = uicontrol('Style','Radio','String','�̤j�Ҷq�a�_������','FontSize',14,'Position',[300 310 200 30],'Parent',considerCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
        set(considerCaseRadioButtonGroup,'SelectedObject',considerCase2);
        set(considerCaseRadioButtonGroup,'Visible','on');
        set(considerCaseRadioButtonGroup,'SelectionChangeFcn',@(source,eventdata) uiresume() );
        
        tap1 = uicontrol('Style','Radio','String','�O�_�@��(�ਤ�g�� = 1.6 sec)','FontSize',14,'Position',[150 250 300 30],'Parent',taipeiRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8]);
        tap2 = uicontrol('Style','Radio','String','�O�_�G��(�ਤ�g�� = 1.3 sec)','FontSize',14,'Position',[150 210 300 30],'Parent',taipeiRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8]);
        tap3 = uicontrol('Style','Radio','String','�O�_�T��(�ਤ�g�� = 1.05 sec)','FontSize',14,'Position',[150 170 300 30],'Parent',taipeiRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8]);
        
        ok_button = uicontrol('Style','pushbutton','String','OK','FontSize',14,'Position',[230 60 100 40],'Callback','uiresume()');
        helpButton = uicontrol(fig1,'Style','pushbutton','String','HELP','FontSize',10,'Position',[500 20 40 25],'Callback','help4_2 = findobj(''tag'',''helpString4_2''), msgbox(get(help4_2,''String''),''HELP'',''help'')');
        prePageButton = uicontrol(fig1,'Style','pushbutton','String','��','FontSize',14,'Position',[20 20 40 25],'Callback','set(findobj(''tag'',''prePage''),''string'',''1'') ; uiresume()');
        
        if T0D == 1.6;
            set(taipeiRadioButtonGroup,'SelectedObject',tap1);
        elseif T0D == 1.3;
            set(taipeiRadioButtonGroup,'SelectedObject',tap2);
        elseif T0D == 1.05;
            set(taipeiRadioButtonGroup,'SelectedObject',tap3);
        else
            set(taipeiRadioButtonGroup,'SelectedObject',[]);
        end
        set(taipeiRadioButtonGroup,'Visible','on');
        uiwait(fig1)
        
        selectedConsiderCaseRadioButton = get(get(considerCaseRadioButtonGroup,'SelectedObject'),'String');
        selected_area = get(get(taipeiRadioButtonGroup,'SelectedObject'),'String');
        close(fig1);
        
        try
            switch selected_area
                case '�O�_�@��(�ਤ�g�� = 1.6 sec)'
                    T0D = 1.6;
                case '�O�_�G��(�ਤ�g�� = 1.3 sec)'
                    T0D = 1.3;
                case '�O�_�T��(�ਤ�g�� = 1.05 sec)'
                    T0D = 1.05;
            end
        end
        
        if str2double(get(findobj('tag','prePage'),'string')) == 1
            prePage = 1;
            return
        end
        
        switch selectedConsiderCaseRadioButton
            case '�]�p�a�_������'
                if considerCase == 2
                    considerCase = 1;
                    continue
                end
            case '�̤j�Ҷq�a�_������'
                if considerCase == 1
                    considerCase = 2;
                    continue
                end
        end
    end
	
	try
        switch selected_area
            case '�O�_�@��(�ਤ�g�� = 1.6 sec)'
                T0D = 1.6;
            case '�O�_�G��(�ਤ�g�� = 1.3 sec)'
                T0D = 1.3;
            case '�O�_�T��(�ਤ�g�� = 1.05 sec)'
                T0D = 1.05;
        end
        page4Continue = 1;
    catch
        errorinformation = lasterror;
        if strcmp(errorinformation.identifier,'MATLAB:badSwitchExpression')
            errorMessageBox = msgbox('�Э��s��ܷL����','ERROR!','error');
            uiwait(errorMessageBox);
        end
    end
end

close(figure(10));