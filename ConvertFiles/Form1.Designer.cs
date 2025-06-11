namespace ConvertFiles
{
    partial class frmConvertFiles
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmConvertFiles));
            this.label1 = new System.Windows.Forms.Label();
            this.txtFieldName = new System.Windows.Forms.TextBox();
            this.btnGotIt = new System.Windows.Forms.Button();
            this.lsResult = new System.Windows.Forms.ListBox();
            this.lblResult = new System.Windows.Forms.Label();
            this.lblPath = new System.Windows.Forms.Label();
            this.txtPath = new System.Windows.Forms.TextBox();
            this.btnExport = new System.Windows.Forms.Button();
            this.tabControl = new System.Windows.Forms.TabControl();
            this.ProgressTab = new System.Windows.Forms.TabPage();
            this.rbActivacionRuta = new System.Windows.Forms.RadioButton();
            this.rbPersonas = new System.Windows.Forms.RadioButton();
            this.rbPlanificacionFamiliar = new System.Windows.Forms.RadioButton();
            this.txtIdentity = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.txtQuery = new System.Windows.Forms.TextBox();
            this.lblConsulta = new System.Windows.Forms.Label();
            this.ExportTab = new System.Windows.Forms.TabPage();
            this.txtExtensionField = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.txtFieldNameExport = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.txtQueryExport = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.lbxResult = new System.Windows.Forms.ListBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txtDestinationPath = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtOriginPath = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.rbComprobantesVerificacion = new System.Windows.Forms.RadioButton();
            this.cboAnio = new System.Windows.Forms.ComboBox();
            this.cboMes = new System.Windows.Forms.ComboBox();
            this.rbReporteActividades = new System.Windows.Forms.RadioButton();
            this.rbAccionesEducativas = new System.Windows.Forms.RadioButton();
            this.txtQueryReporteActividades = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.lbResultReporteActividades = new System.Windows.Forms.ListBox();
            this.label10 = new System.Windows.Forms.Label();
            this.txtDestinationPathReporteActividades = new System.Windows.Forms.TextBox();
            this.label11 = new System.Windows.Forms.Label();
            this.txtOriginalPathReporteActividades = new System.Windows.Forms.TextBox();
            this.label12 = new System.Windows.Forms.Label();
            this.btnExportarReporteActividades = new System.Windows.Forms.Button();
            this.rbPrevencionCovid = new System.Windows.Forms.RadioButton();
            this.rbNavidadSaludable = new System.Windows.Forms.RadioButton();
            this.tabControl.SuspendLayout();
            this.ProgressTab.SuspendLayout();
            this.ExportTab.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 152);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(82, 19);
            this.label1.TabIndex = 2;
            this.label1.Text = "Field Name";
            // 
            // txtFieldName
            // 
            this.txtFieldName.Enabled = false;
            this.txtFieldName.Location = new System.Drawing.Point(10, 174);
            this.txtFieldName.Name = "txtFieldName";
            this.txtFieldName.Size = new System.Drawing.Size(347, 27);
            this.txtFieldName.TabIndex = 3;
            // 
            // btnGotIt
            // 
            this.btnGotIt.Location = new System.Drawing.Point(6, 258);
            this.btnGotIt.Name = "btnGotIt";
            this.btnGotIt.Size = new System.Drawing.Size(75, 23);
            this.btnGotIt.TabIndex = 4;
            this.btnGotIt.Text = "Got It!";
            this.btnGotIt.UseVisualStyleBackColor = true;
            this.btnGotIt.Click += new System.EventHandler(this.btnGotIt_Click);
            // 
            // lsResult
            // 
            this.lsResult.FormattingEnabled = true;
            this.lsResult.ItemHeight = 19;
            this.lsResult.Location = new System.Drawing.Point(11, 310);
            this.lsResult.Name = "lsResult";
            this.lsResult.Size = new System.Drawing.Size(703, 118);
            this.lsResult.TabIndex = 5;
            // 
            // lblResult
            // 
            this.lblResult.AutoSize = true;
            this.lblResult.Location = new System.Drawing.Point(7, 284);
            this.lblResult.Name = "lblResult";
            this.lblResult.Size = new System.Drawing.Size(50, 19);
            this.lblResult.TabIndex = 6;
            this.lblResult.Text = "Result";
            // 
            // lblPath
            // 
            this.lblPath.AutoSize = true;
            this.lblPath.Location = new System.Drawing.Point(7, 204);
            this.lblPath.Name = "lblPath";
            this.lblPath.Size = new System.Drawing.Size(38, 19);
            this.lblPath.TabIndex = 7;
            this.lblPath.Text = "Path";
            // 
            // txtPath
            // 
            this.txtPath.Location = new System.Drawing.Point(10, 225);
            this.txtPath.Name = "txtPath";
            this.txtPath.Size = new System.Drawing.Size(703, 27);
            this.txtPath.TabIndex = 8;
            this.txtPath.Text = "C:\\Sebas\\TFS\\Workspace\\Mias\\MiasTFS\\MiasWorkspace\\Mias\\Archivos";
            // 
            // btnExport
            // 
            this.btnExport.Location = new System.Drawing.Point(11, 243);
            this.btnExport.Name = "btnExport";
            this.btnExport.Size = new System.Drawing.Size(75, 23);
            this.btnExport.TabIndex = 9;
            this.btnExport.Text = "Export";
            this.btnExport.UseVisualStyleBackColor = true;
            this.btnExport.Click += new System.EventHandler(this.btnExport_Click);
            // 
            // tabControl
            // 
            this.tabControl.Controls.Add(this.ProgressTab);
            this.tabControl.Controls.Add(this.ExportTab);
            this.tabControl.Controls.Add(this.tabPage1);
            this.tabControl.Location = new System.Drawing.Point(12, 12);
            this.tabControl.Name = "tabControl";
            this.tabControl.SelectedIndex = 0;
            this.tabControl.Size = new System.Drawing.Size(1104, 466);
            this.tabControl.TabIndex = 10;
            // 
            // ProgressTab
            // 
            this.ProgressTab.Controls.Add(this.rbActivacionRuta);
            this.ProgressTab.Controls.Add(this.rbPersonas);
            this.ProgressTab.Controls.Add(this.rbPlanificacionFamiliar);
            this.ProgressTab.Controls.Add(this.txtIdentity);
            this.ProgressTab.Controls.Add(this.label8);
            this.ProgressTab.Controls.Add(this.txtQuery);
            this.ProgressTab.Controls.Add(this.txtFieldName);
            this.ProgressTab.Controls.Add(this.lblConsulta);
            this.ProgressTab.Controls.Add(this.label1);
            this.ProgressTab.Controls.Add(this.lsResult);
            this.ProgressTab.Controls.Add(this.lblResult);
            this.ProgressTab.Controls.Add(this.txtPath);
            this.ProgressTab.Controls.Add(this.lblPath);
            this.ProgressTab.Controls.Add(this.btnGotIt);
            this.ProgressTab.Location = new System.Drawing.Point(4, 28);
            this.ProgressTab.Name = "ProgressTab";
            this.ProgressTab.Padding = new System.Windows.Forms.Padding(3);
            this.ProgressTab.Size = new System.Drawing.Size(1096, 434);
            this.ProgressTab.TabIndex = 0;
            this.ProgressTab.Text = "Process";
            this.ProgressTab.UseVisualStyleBackColor = true;
            // 
            // rbActivacionRuta
            // 
            this.rbActivacionRuta.AutoSize = true;
            this.rbActivacionRuta.Location = new System.Drawing.Point(365, 84);
            this.rbActivacionRuta.Name = "rbActivacionRuta";
            this.rbActivacionRuta.Size = new System.Drawing.Size(176, 23);
            this.rbActivacionRuta.TabIndex = 13;
            this.rbActivacionRuta.TabStop = true;
            this.rbActivacionRuta.Text = "Reporte de actividades";
            this.rbActivacionRuta.UseVisualStyleBackColor = true;
            this.rbActivacionRuta.CheckedChanged += new System.EventHandler(this.rbActivacionRuta_CheckedChanged);
            // 
            // rbPersonas
            // 
            this.rbPersonas.AutoSize = true;
            this.rbPersonas.Location = new System.Drawing.Point(365, 55);
            this.rbPersonas.Name = "rbPersonas";
            this.rbPersonas.Size = new System.Drawing.Size(86, 23);
            this.rbPersonas.TabIndex = 12;
            this.rbPersonas.TabStop = true;
            this.rbPersonas.Text = "Personas";
            this.rbPersonas.UseVisualStyleBackColor = true;
            this.rbPersonas.CheckedChanged += new System.EventHandler(this.rbPersonas_CheckedChanged);
            // 
            // rbPlanificacionFamiliar
            // 
            this.rbPlanificacionFamiliar.AutoSize = true;
            this.rbPlanificacionFamiliar.Location = new System.Drawing.Point(365, 26);
            this.rbPlanificacionFamiliar.Name = "rbPlanificacionFamiliar";
            this.rbPlanificacionFamiliar.Size = new System.Drawing.Size(165, 23);
            this.rbPlanificacionFamiliar.TabIndex = 11;
            this.rbPlanificacionFamiliar.TabStop = true;
            this.rbPlanificacionFamiliar.Text = "Planificación Familiar";
            this.rbPlanificacionFamiliar.UseVisualStyleBackColor = true;
            this.rbPlanificacionFamiliar.CheckedChanged += new System.EventHandler(this.rbPlanificacionFamiliar_CheckedChanged);
            // 
            // txtIdentity
            // 
            this.txtIdentity.Enabled = false;
            this.txtIdentity.Location = new System.Drawing.Point(365, 174);
            this.txtIdentity.Name = "txtIdentity";
            this.txtIdentity.Size = new System.Drawing.Size(347, 27);
            this.txtIdentity.TabIndex = 10;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(361, 152);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(93, 19);
            this.label8.TabIndex = 9;
            this.label8.Text = "Field Identity";
            // 
            // txtQuery
            // 
            this.txtQuery.Enabled = false;
            this.txtQuery.Location = new System.Drawing.Point(0, 25);
            this.txtQuery.Multiline = true;
            this.txtQuery.Name = "txtQuery";
            this.txtQuery.Size = new System.Drawing.Size(357, 115);
            this.txtQuery.TabIndex = 3;
            // 
            // lblConsulta
            // 
            this.lblConsulta.AutoSize = true;
            this.lblConsulta.Location = new System.Drawing.Point(-4, 3);
            this.lblConsulta.Name = "lblConsulta";
            this.lblConsulta.Size = new System.Drawing.Size(48, 19);
            this.lblConsulta.TabIndex = 2;
            this.lblConsulta.Text = "Query";
            // 
            // ExportTab
            // 
            this.ExportTab.Controls.Add(this.txtExtensionField);
            this.ExportTab.Controls.Add(this.label7);
            this.ExportTab.Controls.Add(this.txtFieldNameExport);
            this.ExportTab.Controls.Add(this.label6);
            this.ExportTab.Controls.Add(this.txtQueryExport);
            this.ExportTab.Controls.Add(this.label5);
            this.ExportTab.Controls.Add(this.lbxResult);
            this.ExportTab.Controls.Add(this.label4);
            this.ExportTab.Controls.Add(this.txtDestinationPath);
            this.ExportTab.Controls.Add(this.label3);
            this.ExportTab.Controls.Add(this.txtOriginPath);
            this.ExportTab.Controls.Add(this.label2);
            this.ExportTab.Controls.Add(this.btnExport);
            this.ExportTab.Location = new System.Drawing.Point(4, 28);
            this.ExportTab.Name = "ExportTab";
            this.ExportTab.Padding = new System.Windows.Forms.Padding(3);
            this.ExportTab.Size = new System.Drawing.Size(1096, 434);
            this.ExportTab.TabIndex = 1;
            this.ExportTab.Text = "Export files";
            this.ExportTab.UseVisualStyleBackColor = true;
            // 
            // txtExtensionField
            // 
            this.txtExtensionField.Location = new System.Drawing.Point(528, 53);
            this.txtExtensionField.Name = "txtExtensionField";
            this.txtExtensionField.Size = new System.Drawing.Size(188, 27);
            this.txtExtensionField.TabIndex = 21;
            this.txtExtensionField.Text = "Extension";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Calibri", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(444, 61);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(78, 13);
            this.label7.TabIndex = 20;
            this.label7.Text = "Extension Field";
            // 
            // txtFieldNameExport
            // 
            this.txtFieldNameExport.Location = new System.Drawing.Point(528, 22);
            this.txtFieldNameExport.Name = "txtFieldNameExport";
            this.txtFieldNameExport.Size = new System.Drawing.Size(188, 27);
            this.txtFieldNameExport.TabIndex = 19;
            this.txtFieldNameExport.Text = "NombreArchivo";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Calibri", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(444, 30);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(76, 13);
            this.label6.TabIndex = 18;
            this.label6.Text = "File name field";
            // 
            // txtQueryExport
            // 
            this.txtQueryExport.Location = new System.Drawing.Point(13, 25);
            this.txtQueryExport.Multiline = true;
            this.txtQueryExport.Name = "txtQueryExport";
            this.txtQueryExport.Size = new System.Drawing.Size(417, 89);
            this.txtQueryExport.TabIndex = 17;
            this.txtQueryExport.Text = resources.GetString("txtQueryExport.Text");
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(9, 3);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(48, 19);
            this.label5.TabIndex = 16;
            this.label5.Text = "Query";
            // 
            // lbxResult
            // 
            this.lbxResult.FormattingEnabled = true;
            this.lbxResult.ItemHeight = 19;
            this.lbxResult.Location = new System.Drawing.Point(13, 291);
            this.lbxResult.Name = "lbxResult";
            this.lbxResult.Size = new System.Drawing.Size(703, 137);
            this.lbxResult.TabIndex = 14;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(9, 269);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(50, 19);
            this.label4.TabIndex = 15;
            this.label4.Text = "Result";
            // 
            // txtDestinationPath
            // 
            this.txtDestinationPath.Location = new System.Drawing.Point(13, 201);
            this.txtDestinationPath.Name = "txtDestinationPath";
            this.txtDestinationPath.Size = new System.Drawing.Size(703, 27);
            this.txtDestinationPath.TabIndex = 13;
            this.txtDestinationPath.Text = "C:\\ArchivosExportadosMIAs";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(9, 179);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(117, 19);
            this.label3.TabIndex = 12;
            this.label3.Text = "Destination Path";
            // 
            // txtOriginPath
            // 
            this.txtOriginPath.Location = new System.Drawing.Point(15, 147);
            this.txtOriginPath.Name = "txtOriginPath";
            this.txtOriginPath.Size = new System.Drawing.Size(703, 27);
            this.txtOriginPath.TabIndex = 11;
            this.txtOriginPath.Text = "C:\\Sebas\\TFS\\Workspace\\Mias\\MiasTFS\\MiasWorkspace\\Mias\\Archivos";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(9, 119);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(82, 19);
            this.label2.TabIndex = 10;
            this.label2.Text = "Origin Path";
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.rbNavidadSaludable);
            this.tabPage1.Controls.Add(this.rbPrevencionCovid);
            this.tabPage1.Controls.Add(this.rbComprobantesVerificacion);
            this.tabPage1.Controls.Add(this.cboAnio);
            this.tabPage1.Controls.Add(this.cboMes);
            this.tabPage1.Controls.Add(this.rbReporteActividades);
            this.tabPage1.Controls.Add(this.rbAccionesEducativas);
            this.tabPage1.Controls.Add(this.txtQueryReporteActividades);
            this.tabPage1.Controls.Add(this.label9);
            this.tabPage1.Controls.Add(this.lbResultReporteActividades);
            this.tabPage1.Controls.Add(this.label10);
            this.tabPage1.Controls.Add(this.txtDestinationPathReporteActividades);
            this.tabPage1.Controls.Add(this.label11);
            this.tabPage1.Controls.Add(this.txtOriginalPathReporteActividades);
            this.tabPage1.Controls.Add(this.label12);
            this.tabPage1.Controls.Add(this.btnExportarReporteActividades);
            this.tabPage1.Location = new System.Drawing.Point(4, 28);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Size = new System.Drawing.Size(1096, 434);
            this.tabPage1.TabIndex = 2;
            this.tabPage1.Text = "Exportar Archivos Actividades";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // rbComprobantesVerificacion
            // 
            this.rbComprobantesVerificacion.AutoSize = true;
            this.rbComprobantesVerificacion.Location = new System.Drawing.Point(554, 85);
            this.rbComprobantesVerificacion.Name = "rbComprobantesVerificacion";
            this.rbComprobantesVerificacion.Size = new System.Drawing.Size(215, 23);
            this.rbComprobantesVerificacion.TabIndex = 34;
            this.rbComprobantesVerificacion.TabStop = true;
            this.rbComprobantesVerificacion.Text = "Comprobantes Verificaciones";
            this.rbComprobantesVerificacion.UseVisualStyleBackColor = true;
            this.rbComprobantesVerificacion.CheckedChanged += new System.EventHandler(this.rbComprobantesVerificacion_CheckedChanged);
            // 
            // cboAnio
            // 
            this.cboAnio.FormattingEnabled = true;
            this.cboAnio.Items.AddRange(new object[] {
            "2020",
            "2021",
            "2022"});
            this.cboAnio.Location = new System.Drawing.Point(331, 23);
            this.cboAnio.Name = "cboAnio";
            this.cboAnio.Size = new System.Drawing.Size(188, 27);
            this.cboAnio.TabIndex = 33;
            // 
            // cboMes
            // 
            this.cboMes.FormattingEnabled = true;
            this.cboMes.Items.AddRange(new object[] {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12"});
            this.cboMes.Location = new System.Drawing.Point(331, 56);
            this.cboMes.Name = "cboMes";
            this.cboMes.Size = new System.Drawing.Size(188, 27);
            this.cboMes.TabIndex = 32;
            // 
            // rbReporteActividades
            // 
            this.rbReporteActividades.AutoSize = true;
            this.rbReporteActividades.Location = new System.Drawing.Point(554, 56);
            this.rbReporteActividades.Name = "rbReporteActividades";
            this.rbReporteActividades.Size = new System.Drawing.Size(156, 23);
            this.rbReporteActividades.TabIndex = 31;
            this.rbReporteActividades.TabStop = true;
            this.rbReporteActividades.Text = "Reporte actividades";
            this.rbReporteActividades.UseVisualStyleBackColor = true;
            this.rbReporteActividades.CheckedChanged += new System.EventHandler(this.rbReporteActividades_CheckedChanged);
            // 
            // rbAccionesEducativas
            // 
            this.rbAccionesEducativas.AutoSize = true;
            this.rbAccionesEducativas.Location = new System.Drawing.Point(554, 27);
            this.rbAccionesEducativas.Name = "rbAccionesEducativas";
            this.rbAccionesEducativas.Size = new System.Drawing.Size(159, 23);
            this.rbAccionesEducativas.TabIndex = 30;
            this.rbAccionesEducativas.TabStop = true;
            this.rbAccionesEducativas.Text = "Acciones educativas";
            this.rbAccionesEducativas.UseVisualStyleBackColor = true;
            this.rbAccionesEducativas.CheckedChanged += new System.EventHandler(this.rbAccionesEducativas_CheckedChanged);
            // 
            // txtQueryReporteActividades
            // 
            this.txtQueryReporteActividades.Location = new System.Drawing.Point(16, 27);
            this.txtQueryReporteActividades.Multiline = true;
            this.txtQueryReporteActividades.Name = "txtQueryReporteActividades";
            this.txtQueryReporteActividades.Size = new System.Drawing.Size(297, 89);
            this.txtQueryReporteActividades.TabIndex = 28;
            this.txtQueryReporteActividades.Text = resources.GetString("txtQueryReporteActividades.Text");
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(12, 5);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(48, 19);
            this.label9.TabIndex = 27;
            this.label9.Text = "Query";
            // 
            // lbResultReporteActividades
            // 
            this.lbResultReporteActividades.FormattingEnabled = true;
            this.lbResultReporteActividades.ItemHeight = 19;
            this.lbResultReporteActividades.Location = new System.Drawing.Point(16, 293);
            this.lbResultReporteActividades.Name = "lbResultReporteActividades";
            this.lbResultReporteActividades.Size = new System.Drawing.Size(1077, 137);
            this.lbResultReporteActividades.TabIndex = 25;
            this.lbResultReporteActividades.KeyDown += new System.Windows.Forms.KeyEventHandler(this.lbResultReporteActividades_KeyDown);
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(12, 271);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(50, 19);
            this.label10.TabIndex = 26;
            this.label10.Text = "Result";
            // 
            // txtDestinationPathReporteActividades
            // 
            this.txtDestinationPathReporteActividades.Location = new System.Drawing.Point(16, 203);
            this.txtDestinationPathReporteActividades.Name = "txtDestinationPathReporteActividades";
            this.txtDestinationPathReporteActividades.Size = new System.Drawing.Size(1077, 27);
            this.txtDestinationPathReporteActividades.TabIndex = 24;
            this.txtDestinationPathReporteActividades.Text = "C:\\ArchivosExportadosMIAs";
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(12, 181);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(117, 19);
            this.label11.TabIndex = 23;
            this.label11.Text = "Destination Path";
            // 
            // txtOriginalPathReporteActividades
            // 
            this.txtOriginalPathReporteActividades.Location = new System.Drawing.Point(18, 149);
            this.txtOriginalPathReporteActividades.Name = "txtOriginalPathReporteActividades";
            this.txtOriginalPathReporteActividades.Size = new System.Drawing.Size(1075, 27);
            this.txtOriginalPathReporteActividades.TabIndex = 22;
            this.txtOriginalPathReporteActividades.Text = "C:\\Sebas\\TFS\\Workspace\\Mias\\MiasTFS\\MiasWorkspace\\Mias\\Archivos";
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(12, 121);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(82, 19);
            this.label12.TabIndex = 21;
            this.label12.Text = "Origin Path";
            // 
            // btnExportarReporteActividades
            // 
            this.btnExportarReporteActividades.Location = new System.Drawing.Point(14, 245);
            this.btnExportarReporteActividades.Name = "btnExportarReporteActividades";
            this.btnExportarReporteActividades.Size = new System.Drawing.Size(75, 23);
            this.btnExportarReporteActividades.TabIndex = 20;
            this.btnExportarReporteActividades.Text = "Export";
            this.btnExportarReporteActividades.UseVisualStyleBackColor = true;
            this.btnExportarReporteActividades.Click += new System.EventHandler(this.btnExportarReporteActividades_Click);
            // 
            // rbPrevencionCovid
            // 
            this.rbPrevencionCovid.AutoSize = true;
            this.rbPrevencionCovid.Location = new System.Drawing.Point(797, 28);
            this.rbPrevencionCovid.Name = "rbPrevencionCovid";
            this.rbPrevencionCovid.Size = new System.Drawing.Size(138, 23);
            this.rbPrevencionCovid.TabIndex = 35;
            this.rbPrevencionCovid.TabStop = true;
            this.rbPrevencionCovid.Text = "Prevención Covid";
            this.rbPrevencionCovid.UseVisualStyleBackColor = true;
            this.rbPrevencionCovid.CheckedChanged += new System.EventHandler(this.rbPrevencionCovid_CheckedChanged);
            // 
            // rbNavidadSaludable
            // 
            this.rbNavidadSaludable.AutoSize = true;
            this.rbNavidadSaludable.Location = new System.Drawing.Point(797, 56);
            this.rbNavidadSaludable.Name = "rbNavidadSaludable";
            this.rbNavidadSaludable.Size = new System.Drawing.Size(147, 23);
            this.rbNavidadSaludable.TabIndex = 36;
            this.rbNavidadSaludable.TabStop = true;
            this.rbNavidadSaludable.Text = "Navidad Saludable";
            this.rbNavidadSaludable.UseVisualStyleBackColor = true;
            this.rbNavidadSaludable.CheckedChanged += new System.EventHandler(this.rbNavidadSaludable_CheckedChanged);
            // 
            // frmConvertFiles
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 19F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1128, 500);
            this.Controls.Add(this.tabControl);
            this.Font = new System.Drawing.Font("Calibri", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Margin = new System.Windows.Forms.Padding(4);
            this.MaximizeBox = false;
            this.Name = "frmConvertFiles";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Convertir Archivos By SP";
            this.Load += new System.EventHandler(this.frmConvertFiles_Load);
            this.tabControl.ResumeLayout(false);
            this.ProgressTab.ResumeLayout(false);
            this.ProgressTab.PerformLayout();
            this.ExportTab.ResumeLayout(false);
            this.ExportTab.PerformLayout();
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtFieldName;
        private System.Windows.Forms.Button btnGotIt;
        private System.Windows.Forms.ListBox lsResult;
        private System.Windows.Forms.Label lblResult;
        private System.Windows.Forms.Label lblPath;
        private System.Windows.Forms.TextBox txtPath;
        private System.Windows.Forms.Button btnExport;
        private System.Windows.Forms.TabControl tabControl;
        private System.Windows.Forms.TabPage ProgressTab;
        private System.Windows.Forms.TextBox txtQuery;
        private System.Windows.Forms.Label lblConsulta;
        private System.Windows.Forms.TabPage ExportTab;
        private System.Windows.Forms.TextBox txtDestinationPath;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtOriginPath;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ListBox lbxResult;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtQueryExport;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txtExtensionField;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txtFieldNameExport;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtIdentity;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.RadioButton rbPersonas;
        private System.Windows.Forms.RadioButton rbPlanificacionFamiliar;
        private System.Windows.Forms.RadioButton rbActivacionRuta;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.ComboBox cboAnio;
        private System.Windows.Forms.ComboBox cboMes;
        private System.Windows.Forms.RadioButton rbReporteActividades;
        private System.Windows.Forms.RadioButton rbAccionesEducativas;
        private System.Windows.Forms.TextBox txtQueryReporteActividades;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.ListBox lbResultReporteActividades;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox txtDestinationPathReporteActividades;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.TextBox txtOriginalPathReporteActividades;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.Button btnExportarReporteActividades;
        private System.Windows.Forms.RadioButton rbComprobantesVerificacion;
        private System.Windows.Forms.RadioButton rbNavidadSaludable;
        private System.Windows.Forms.RadioButton rbPrevencionCovid;
    }
}

