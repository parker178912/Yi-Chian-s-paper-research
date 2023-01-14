function [SsD,S1D,Fa,Fv,Na,Nv,considerCase,prePage] = page3(SsD,S1D,Fa,Fv,Na,Nv,considerCase)

prePage = 0;
set(figure(10),'Visible','off');
helpString3 = text('tag','helpString3','string',{'�п�J�u�g���]�p�����Х[�t�׫Y��SsD�G�Цb��r�϶���J�̤u�}�d�o��SsD�C';
	'�п�J1��g���]�p�����Х[�t�׫Y��S1D�G�Цb��r�϶�����J�̤u�}�d�o��S1D�C';
	'�п�J���[�t�׬q�u�}��j�Y��Fa�G�Цb��r�϶�����J�̤u�}�a�L�d�o���վ�]�lFa�C';
	'�п�J���t�׬q�u�}��j�Y��Fv�G�Цb��r�϶�����J�̤u�}�a�L�d�o���վ�]�lFv�C';
	'�п�J���[�t�׬q���_�h�վ�]�lNa�G�Цb��r�϶�����J�̤u�}�d�o�����_�h�վ�]�lNa�C           .';
	'�п�J���t�׬q���_�h�վ�]�lNv�G�Цb��r�϶�����J�̤u�}�d�o�����_�h�վ�]�lNv�C';
    '';
	'���UOK��i�qFigure(4)�ˬd�]�p�����СC'});
helpString3_2 = text('tag','helpString3_2','string',{'�п�J�u�g���̤j�Ҷq�����Х[�t�׫Y��SsM�G�Цb��r�϶���J�̤u�}�d�o��SsM�C';
	'�п�J1��g���̤j�Ҷq�����Х[�t�׫Y��S1M�G�Цb��r�϶�����J�̤u�}�d�o��S1M�C';
	'�п�J���[�t�׬q�u�}��j�Y��Fa�G�Цb��r�϶�����J�̤u�}�a�L�d�o���վ�]�lFa�C';
	'�п�J���t�׬q�u�}��j�Y��Fv�G�Цb��r�϶�����J�̤u�}�a�L�d�o���վ�]�lFv�C';
	'�п�J���[�t�׬q���_�h�վ�]�lNa�G�Цb��r�϶�����J�̤u�}�d�o�����_�h�վ�]�lNa�C           .';
	'�п�J���t�׬q���_�h�վ�]�lNv�G�Цb��r�϶�����J�̤u�}�d�o�����_�h�վ�]�lNv�C';
    '';
	'���UOK��i�qFigure(4)�ˬd�̤j�Ҷq�����СC'});
prePageText = text('tag','prePage','string','0');

page3Continue = 0;
while (page3Continue == 0)
    if considerCase == 1;
        fig1 = figure(1);
        set(fig1,'Resize','off');
        design_spectrum_text = uicontrol(fig1,'Style','text','String','�п�J�@��a�ϳ]�p�����Э�','FontSize',14,'Position',[160 380 250 26],'BackgroundColor',[0.8 0.8 0.8]);
        
        considerCaseRadioButtonGroup = uibuttongroup(fig1,'visible','off','BackgroundColor',[0.8 0.8 0.8]);
        considerCase1 = uicontrol('Style','Radio','String','�]�p�a�_������','FontSize',14,'Position',[100 340 200 30],'Parent',considerCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
        considerCase2 = uicontrol('Style','Radio','String','�̤j�Ҷq�a�_������','FontSize',14,'Position',[300 340 200 30],'Parent',considerCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
        set(considerCaseRadioButtonGroup,'SelectedObject',considerCase1);
        set(considerCaseRadioButtonGroup,'Visible','on');
        set(considerCaseRadioButtonGroup,'SelectionChangeFcn',@(source,eventdata) uiresume() );
            
        SsD_text = uicontrol(fig1,'Style','text','String','�п�J�u�g���]�p�����Х[�t�׫Y��S  (g)','FontSize',14,'Position',[40 300 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        SsD_sub_D_text = uicontrol(fig1,'Style','text','String','D','FontSize',8,'Position',[382 318 8 10],'BackgroundColor',[0.8 0.8 0.8]);
        SsD_sub_S_text = uicontrol(fig1,'Style','text','String','S','FontSize',8,'Position',[382 305 8 10],'BackgroundColor',[0.8 0.8 0.8]);
        SsD_edit = uicontrol(fig1,'Style','edit','String',SsD,'FontSize',14,'Position',[420 300 80 26]);
        
        S1D_text = uicontrol(fig1,'Style','text','String','�п�J1��g���]�p�����Х[�t�׫Y��S  (g)','FontSize',14,'Position',[35 260 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        S1D_sub_D_text = uicontrol(fig1,'Style','text','String','D','FontSize',8,'Position',[382 278 8 10],'BackgroundColor',[0.8 0.8 0.8]);
        S1D_sub_1_text = uicontrol(fig1,'Style','text','String','1','FontSize',8,'Position',[382 265 8 10],'BackgroundColor',[0.8 0.8 0.8]);
        S1D_edit = uicontrol(fig1,'Style','edit','String',S1D,'FontSize',14,'Position',[420 260 80 26]);
        
        Fa_text = uicontrol(fig1,'Style','text','String','�п�J���[�t�׬q�u�}��j�Y��F  ','FontSize',14,'Position',[70 220 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        Fa_sub_a_text = uicontrol(fig1,'Style','text','String','a','FontSize',8,'Position',[402 225 8 10],'BackgroundColor',[0.8 0.8 0.8]);
        Fa_edit = uicontrol(fig1,'Style','edit','String',Fa,'FontSize',14,'Position',[420 220 80 26]);
            
        Fv_text = uicontrol(fig1,'Style','text','String','�п�J���t�׬q�u�}��j�Y��F  ','FontSize',14,'Position',[80 180 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        Fv_sub_a_text = uicontrol(fig1,'Style','text','String','v','FontSize',8,'Position',[402 185 8 10],'BackgroundColor',[0.8 0.8 0.8]);
        Fv_edit = uicontrol(fig1,'Style','edit','String',Fv,'FontSize',14,'Position',[420 180 80 26]);
            
        Na_text = uicontrol(fig1,'Style','text','String','�п�J���[�t�׬q���_�h�վ�]�lN  ','FontSize',14,'Position',[60 140 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        Na_sub_a_text = uicontrol(fig1,'Style','text','String','a','FontSize',8,'Position',[405 145 8 10],'BackgroundColor',[0.8 0.8 0.8]);
        Na_edit = uicontrol(fig1,'Style','edit','String',Na,'FontSize',14,'Position',[420 140 80 26]);
        
        Nv_text = uicontrol(fig1,'Style','text','String','�п�J���t�׬q���_�h�վ�]�lN  ','FontSize',14,'Position',[70 100 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        Nv_sub_a_text = uicontrol(fig1,'Style','text','String','v','FontSize',8,'Position',[405 105 8 10],'BackgroundColor',[0.8 0.8 0.8]);
        Nv_edit = uicontrol(fig1,'Style','edit','String',Nv,'FontSize',14,'Position',[420 100 80 26]);
        
        ok_button = uicontrol(fig1,'Style','pushbutton','String','OK','FontSize',14,'Position',[230 40 100 40],'Callback','uiresume()');
        helpButton = uicontrol(fig1,'Style','pushbutton','String','HELP','FontSize',10,'Position',[500 20 40 25],'Callback','help3 = findobj(''tag'',''helpString3''), msgbox(get(help3,''String''),''HELP'',''help'')');
        prePageButton = uicontrol(fig1,'Style','pushbutton','String','��','FontSize',14,'Position',[20 20 40 25],'Callback','set(findobj(''tag'',''prePage''),''string'',''1'') ; uiresume()');
        
        uiwait(fig1);
        SsD = get(SsD_edit,'String');
        S1D = get(S1D_edit,'String');
        Fa = get(Fa_edit,'String');
        Fv = get(Fv_edit,'String');
        Na = get(Na_edit,'String');
        Nv = get(Nv_edit,'String');
        
        selectedConsiderCaseRadioButton = get(get(considerCaseRadioButtonGroup,'SelectedObject'),'String');
        close(fig1);
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
        
        if isnan(str2double(SsD))
            errorMessageBox = msgbox('SsD��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(SsD) <= 0
            errorMessageBox = msgbox('SsD��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif isnan(str2double(S1D))
            errorMessageBox = msgbox('S1D��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(S1D) <= 0
            errorMessageBox = msgbox('S1D��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif isnan(str2double(Fa))
            errorMessageBox = msgbox('Fa��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(Fa) < 1
            errorMessageBox = msgbox('Fa��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif isnan(str2double(Fv))
            errorMessageBox = msgbox('Fv��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(Fv) < 1
            errorMessageBox = msgbox('Fv��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif isnan(str2double(Na))
            errorMessageBox = msgbox('Na��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(Na) < 1
            errorMessageBox = msgbox('Na��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif isnan(str2double(Nv))
            errorMessageBox = msgbox('Nv��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(Nv) < 1
            errorMessageBox = msgbox('Nv��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        else
            page3Continue = 1;
        end
        
    else
        fig1 = figure(1);
        set(fig1,'Resize','off');
        design_spectrum_text = uicontrol(fig1,'Style','text','String','�п�J�@��a�ϳ̤j�Ҷq�����Э�','FontSize',14,'Position',[135 380 300 26],'BackgroundColor',[0.8 0.8 0.8]);
        
        considerCaseRadioButtonGroup = uibuttongroup(fig1,'visible','off','BackgroundColor',[0.8 0.8 0.8]);
        considerCase1 = uicontrol('Style','Radio','String','�]�p�a�_������','FontSize',14,'Position',[100 340 200 30],'Parent',considerCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
        considerCase2 = uicontrol('Style','Radio','String','�̤j�Ҷq�a�_������','FontSize',14,'Position',[300 340 200 30],'Parent',considerCaseRadioButtonGroup,'BackgroundColor',[0.8 0.8 0.8],'HandleVisibility','off');
        set(considerCaseRadioButtonGroup,'SelectedObject',considerCase2);
        set(considerCaseRadioButtonGroup,'Visible','on');
        set(considerCaseRadioButtonGroup,'SelectionChangeFcn',@(source,eventdata) uiresume() );
        
        SsD_text = uicontrol(fig1,'Style','text','String','�п�J�u�g���̤j�Ҷq�����Х[�t�׫Y��S  (g)','FontSize',14,'Position',[20 300 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        SsD_sub_D_text = uicontrol(fig1,'Style','text','String','M','FontSize',8,'Position',[382 318 8 11],'BackgroundColor',[0.8 0.8 0.8]);
        SsD_sub_S_text = uicontrol(fig1,'Style','text','String','S','FontSize',8,'Position',[382 305 8 11],'BackgroundColor',[0.8 0.8 0.8]);
        SsD_edit = uicontrol(fig1,'Style','edit','String',SsD,'FontSize',14,'Position',[420 300 80 26]);
        
        S1D_text = uicontrol(fig1,'Style','text','String','�п�J1��g���̤j�Ҷq�����Х[�t�׫Y��S  (g)','FontSize',14,'Position',[15 260 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        S1D_sub_D_text = uicontrol(fig1,'Style','text','String','M','FontSize',8,'Position',[382 278 8 11],'BackgroundColor',[0.8 0.8 0.8]);
        S1D_sub_1_text = uicontrol(fig1,'Style','text','String','1','FontSize',8,'Position',[382 265 8 11],'BackgroundColor',[0.8 0.8 0.8]);
        S1D_edit = uicontrol(fig1,'Style','edit','String',S1D,'FontSize',14,'Position',[420 260 80 26]);
        
        Fa_text = uicontrol(fig1,'Style','text','String','�п�J���[�t�׬q�u�}��j�Y��F  ','FontSize',14,'Position',[70 220 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        Fa_sub_a_text = uicontrol(fig1,'Style','text','String','a','FontSize',8,'Position',[402 225 8 11],'BackgroundColor',[0.8 0.8 0.8]);
        Fa_edit = uicontrol(fig1,'Style','edit','String',Fa,'FontSize',14,'Position',[420 220 80 26]);
        
        Fv_text = uicontrol(fig1,'Style','text','String','�п�J���t�׬q�u�}��j�Y��F  ','FontSize',14,'Position',[80 180 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        Fv_sub_a_text = uicontrol(fig1,'Style','text','String','v','FontSize',8,'Position',[402 185 8 11],'BackgroundColor',[0.8 0.8 0.8]);
        Fv_edit = uicontrol(fig1,'Style','edit','String',Fv,'FontSize',14,'Position',[420 180 80 26]);
        
        Na_text = uicontrol(fig1,'Style','text','String','�п�J���[�t�׬q���_�h�վ�]�lN  ','FontSize',14,'Position',[60 140 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        Na_sub_a_text = uicontrol(fig1,'Style','text','String','a','FontSize',8,'Position',[405 145 8 11],'BackgroundColor',[0.8 0.8 0.8]);
        Na_edit = uicontrol(fig1,'Style','edit','String',Na,'FontSize',14,'Position',[420 140 80 26]);
        
        Nv_text = uicontrol(fig1,'Style','text','String','�п�J���t�׬q���_�h�վ�]�lN  ','FontSize',14,'Position',[70 100 400 26],'BackgroundColor',[0.8 0.8 0.8]);
        Nv_sub_a_text = uicontrol(fig1,'Style','text','String','v','FontSize',8,'Position',[405 105 8 11],'BackgroundColor',[0.8 0.8 0.8]);
        Nv_edit = uicontrol(fig1,'Style','edit','String',Nv,'FontSize',14,'Position',[420 100 80 26]);
        
        ok_button = uicontrol(fig1,'Style','pushbutton','String','OK','FontSize',14,'Position',[230 40 100 40],'Callback','uiresume()');
        helpButton = uicontrol(fig1,'Style','pushbutton','String','HELP','FontSize',10,'Position',[500 20 40 25],'Callback','help3_2 = findobj(''tag'',''helpString3_2''), msgbox(get(help3_2,''String''),''HELP'',''help'')');
        prePageButton = uicontrol(fig1,'Style','pushbutton','String','��','FontSize',14,'Position',[20 20 40 25],'Callback','set(findobj(''tag'',''prePage''),''string'',''1'') ; uiresume()');
        
        uiwait(fig1)
        SsD = get(SsD_edit,'String');
        S1D = get(S1D_edit,'String');
        Fa = get(Fa_edit,'String');
        Fv = get(Fv_edit,'String');
        Na = get(Na_edit,'String');
        Nv = get(Nv_edit,'String');
        
        selectedConsiderCaseRadioButton = get(get(considerCaseRadioButtonGroup,'SelectedObject'),'String');
        
        close(fig1);
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
        
        if isnan(str2double(SsD))
            errorMessageBox = msgbox('SsD��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(SsD) <= 0
            errorMessageBox = msgbox('SsD��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif isnan(str2double(S1D))
            errorMessageBox = msgbox('S1D��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(S1D) <= 0
            errorMessageBox = msgbox('S1D��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif isnan(str2double(Fa))
            errorMessageBox = msgbox('Fa��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(Fa) < 1
            errorMessageBox = msgbox('Fa��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif isnan(str2double(Fv))
            errorMessageBox = msgbox('Fv��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(Fv) < 1
            errorMessageBox = msgbox('Fv��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif isnan(str2double(Na))
            errorMessageBox = msgbox('Na��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(Na) < 1
            errorMessageBox = msgbox('Na��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif isnan(str2double(Nv))
            errorMessageBox = msgbox('Nv��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        elseif str2double(Nv) < 1
            errorMessageBox = msgbox('Nv��J���~','ERROR!','error');
            uiwait(errorMessageBox);
        else
            page3Continue = 1;
        end
    end
end

close(figure(10));