using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ConvertFiles
{
    public partial class frmConvertFiles : Form
    {
        private delegate void SafeCallDelegate(string text);
        private delegate void SafeCallDelegateExport(string text);
        Thread thr;
        Dictionary<int, byte[]> ByteFilesList = new Dictionary<int, byte[]>();
        const string ConnectionString = "Password=M1as*70032316;Persist Security Info=True;User ID=IUSR_MIAS;Initial Catalog=BDMIAS;Data Source=10.11.1.93";
        //const string ConnectionString = "Password=M1as*70032316;Persist Security Info=True;User ID=IUSR_MIAS;Initial Catalog=DBMIASDEVELOP;Data Source=10.11.1.93";

        public frmConvertFiles()
        {
            InitializeComponent();
        }

        private void btnGotIt_Click(object sender, EventArgs e)
        {
            if (txtQuery.Text == string.Empty)
            {
                MessageBox.Show("Seleccione un tipo");
                return;
            }
            thr = new Thread(new ThreadStart(convertFiles));
            thr.Start();
        }

        private void convertFiles()
        {

            SqlDataReader reader;
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = txtQuery.Text;
                    reader = command.ExecuteReader();

                    WriteTextSafe("Query Executing... O ejecutando consulta para que entienda Rafa.");
                    WriteTextSafe("Preparando...");
                    while (reader.Read())
                    {
                        byte[] myByte = (byte[])reader[txtFieldName.Text];
                        string h = reader[txtIdentity.Text].ToString();
                        ByteFilesList.Add(Convert.ToInt32(h), myByte);
                    }
                }
                connection.Close();
            }

            string path = txtPath.Text;
            if (!path.EndsWith(@"\"))
            {
                path = path + @"\";
            }
            if (!Directory.Exists(path))
            {
                MessageBox.Show("No existe el directorio");
                return;
            }
            WriteTextSafe("Archivos encontrados:" + ByteFilesList.Count);
            int i = 0;
            foreach (KeyValuePair<int, byte[]> kvp in ByteFilesList)
            {
                byte[] keyBytes = (byte[])kvp.Value;

                string fileName = Guid.NewGuid().ToString();
                System.IO.FileStream archivo = new System.IO.FileStream(path + fileName, System.IO.FileMode.Create, System.IO.FileAccess.Write);
                archivo.Write(keyBytes, 0, keyBytes.Length);
                archivo.Close();

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand())
                    {
                        if (rbPlanificacionFamiliar.Checked)
                        {
                            List<SqlParameter> parameters = new List<SqlParameter>();
                            SqlParameter pIdArchivo = new SqlParameter();
                            pIdArchivo.ParameterName = "@idArchivo";
                            pIdArchivo.SqlDbType = SqlDbType.Int;
                            pIdArchivo.Value = kvp.Key;

                            SqlParameter pGuid = new SqlParameter();
                            pGuid.ParameterName = "@Guid";
                            pGuid.SqlDbType = SqlDbType.VarChar;
                            pGuid.Value = fileName;

                            parameters.Add(pIdArchivo);
                            parameters.Add(pGuid);

                            command.Connection = connection;
                            command.CommandText = "dbop_Update_TBLArchivo_Guid";
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.AddRange(parameters.ToArray());
                            command.ExecuteNonQuery();
                        }
                        if (rbPersonas.Checked)
                        {
                            List<SqlParameter> parameters = new List<SqlParameter>();
                            SqlParameter pIdArchivo = new SqlParameter();
                            pIdArchivo.ParameterName = "@idArchivoPersona";
                            pIdArchivo.SqlDbType = SqlDbType.Int;
                            pIdArchivo.Value = kvp.Key;

                            SqlParameter pGuid = new SqlParameter();
                            pGuid.ParameterName = "@Guid";
                            pGuid.SqlDbType = SqlDbType.VarChar;
                            pGuid.Value = fileName;

                            parameters.Add(pIdArchivo);
                            parameters.Add(pGuid);

                            command.Connection = connection;
                            command.CommandText = "dbop_Update_TBLArchivoPersona_Guid";
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.AddRange(parameters.ToArray());
                            command.ExecuteNonQuery();
                        }
                        if (rbActivacionRuta.Checked)
                        {
                            List<SqlParameter> parameters = new List<SqlParameter>();
                            SqlParameter pIdArchivo = new SqlParameter();
                            pIdArchivo.ParameterName = "@id";
                            pIdArchivo.SqlDbType = SqlDbType.Int;
                            pIdArchivo.Value = kvp.Key;

                            SqlParameter pGuid = new SqlParameter();
                            pGuid.ParameterName = "@Guid";
                            pGuid.SqlDbType = SqlDbType.VarChar;
                            pGuid.Value = fileName;

                            parameters.Add(pIdArchivo);
                            parameters.Add(pGuid);

                            command.Connection = connection;
                            command.CommandText = "dbop_Update_TBL_REPORTEACTIVIDADES_Guid";
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.AddRange(parameters.ToArray());
                            command.ExecuteNonQuery();
                        }

                    }
                    connection.Close();
                }

                WriteTextSafe("Archivo " + (i + 1).ToString() + " Convertido satisfactoriamente");
                i++;
            }
            ByteFilesList.Clear();
        }

        public byte[] FileToByteArray(string fileName)
        {
            byte[] buff = null;
            FileStream fs = new FileStream(fileName,
                                           FileMode.Open,
                                           FileAccess.Read);
            BinaryReader br = new BinaryReader(fs);
            long numBytes = new FileInfo(fileName).Length;
            buff = br.ReadBytes((int)numBytes);
            return buff;
        }

        private void WriteTextSafe(string text)
        {
            if (lsResult.InvokeRequired)
            {
                var d = new SafeCallDelegate(WriteTextSafe);
                lsResult.Invoke(d, new object[] { text });
            }
            else
            {
                lsResult.Items.Add(text);
            }
        }

        private void WriteTextSafeExport(string text)
        {
            if (lbxResult.InvokeRequired)
            {
                var d = new SafeCallDelegateExport(WriteTextSafeExport);
                lbxResult.Invoke(d, new object[] { text });
            }
            else
            {
                lbxResult.Items.Add(text);
            }
        }

        private void WriteTextSafeExportReporteActividades(string text)
        {
            if (lbResultReporteActividades.InvokeRequired)
            {
                var d = new SafeCallDelegateExport(WriteTextSafeExportReporteActividades);
                lbResultReporteActividades.Invoke(d, new object[] { text });
            }
            else
            {
                lbResultReporteActividades.Items.Add(text);
            }
        }

        private void frmConvertFiles_Load(object sender, EventArgs e)
        {
        }

        private void btnExport_Click(object sender, EventArgs e)
        {
            thr = new Thread(new ThreadStart(ExportFiles));
            thr.Start();
        }

        private void ExportFiles()
        {
            SqlDataReader reader;
            string path;
            string nameBD;
            string extension;
            string guidFile;
            int count = 0;
            try
            {
                path = txtOriginPath.Text;
                if (path == string.Empty)
                {
                    MessageBox.Show("No hay ninguna ruta.");
                    return;
                }
                DirectoryInfo d = new DirectoryInfo(path);

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandText = txtQueryExport.Text;
                        WriteTextSafeExport("Query Executing...");
                        reader = command.ExecuteReader();
                        WriteTextSafeExport("Total files:" + reader.FieldCount.ToString());

                        while (reader.Read())
                        {
                            string tmp_PATH = txtDestinationPath.Text + "\\";
                            nameBD = reader[txtFieldNameExport.Text].ToString();
                            extension = reader[txtExtensionField.Text].ToString();
                            guidFile = reader["Guid"].ToString();
                            tmp_PATH = tmp_PATH + reader["NombreComuna"].ToString();
                            if (!Directory.Exists(tmp_PATH))
                            {
                                Directory.CreateDirectory(tmp_PATH);
                            }
                            File.Copy(txtOriginPath.Text + "\\" + guidFile, tmp_PATH + "\\" + nameBD);
                            WriteTextSafeExport(nameBD + " -- OK");
                            count++;
                        }
                        WriteTextSafeExport("Exported Files:" + count);
                    }
                    connection.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void rbPlanificacionFamiliar_CheckedChanged(object sender, EventArgs e)
        {
            if (rbPlanificacionFamiliar.Checked)
            {
                txtQuery.Text = "Select * from TBL_ARCHIVOS";
                txtIdentity.Text = "idArchivo";
                txtFieldName.Text = "Archivo";
            }
            else
            {
                txtQuery.Text = "";
                txtIdentity.Text = "";
                txtFieldName.Text = "";
            }
        }

        private void rbPersonas_CheckedChanged(object sender, EventArgs e)
        {
            if (rbPersonas.Checked)
            {
                txtQuery.Text = "Select * from TBL_ARCHIVOPERSONA";
                txtIdentity.Text = "IdArchivoPersona";
                txtFieldName.Text = "Archivo";
            }
            else
            {
                txtQuery.Text = "";
                txtIdentity.Text = "";
                txtFieldName.Text = "";
            }
        }

        private void rbActivacionRuta_CheckedChanged(object sender, EventArgs e)
        {
            if (rbActivacionRuta.Checked)
            {
                txtQuery.Text = "Select top 500 * from [TBL_REPORTEACTIVIDADES] WHERE Archivo IS NOT NULL AND [guid] Is null";
                txtIdentity.Text = "IdReporteActividad";
                txtFieldName.Text = "Archivo";
            }
            else
            {
                txtQuery.Text = "";
                txtIdentity.Text = "";
                txtFieldName.Text = "";
            }
        }

        private void rbAccionesEducativas_CheckedChanged(object sender, EventArgs e)
        {
            if (rbAccionesEducativas.Checked)
            {
                txtQueryReporteActividades.Text = "SELECT  [IdReporteActividad],[Fecha],MONTH(Fecha) as mes,RA.[IdComuna],C.NombreComuna,AE.NombreCategoria,RA.[IdBarrio],RA.[IdLugar],L.[NombreLugar],CAST(IdReporteActividad as varchar) +'_' + CAST(Fecha as varchar) +'_' + ISNULL(L.NombreLugar, 'SIN_LUGAR') + Extension as nombreArchivo,[guid] FROM [dbo].[TBL_REPORTEACTIVIDADES] RA LEFT JOIN TBL_MAECATEGORIAACCIONEDUCATIVA AE ON RA.IdMaeCategoriaAccionEducativa = AE.IdMaeCategoriaAccionEducativa LEFT JOIN TBL_LUGAR L ON RA.IdLugar = L.IdLugar LEFT JOIN TBL_COMUNAS C ON RA.IdComuna = C.IdComuna WHERE TipoActividad = 'Acción Educativa' and YEAR(fecha) = " + cboAnio.SelectedItem + " and MONTH(fecha) = " + cboMes.SelectedItem;
            }
            else
            {
                txtQueryReporteActividades.Text = "";
            }
        }

        private void rbReporteActividades_CheckedChanged(object sender, EventArgs e)
        {
            if (rbReporteActividades.Checked)
            {
                txtQueryReporteActividades.Text = "SELECT U.PrimerNombre + '_' + U.PrimerApellido as profesional, P.NombrePerfil, [IdReporteActividad],[Fecha],MONTH(Fecha) as mes,RA.[IdComuna],C.NombreComuna,AE.NombreCategoria,RA.[IdBarrio],RA.[IdLugar],L.[NombreLugar],CAST(IdReporteActividad as varchar) +'_' + U.PrimerNombre + '_' + U.PrimerApellido +'_ReporteActividad' + Extension as nombreArchivo,[guid] FROM [dbo].[TBL_REPORTEACTIVIDADES] RA LEFT JOIN TBL_MAECATEGORIAACCIONEDUCATIVA AE ON RA.IdMaeCategoriaAccionEducativa = AE.IdMaeCategoriaAccionEducativa LEFT JOIN TBL_LUGAR L ON RA.IdLugar = L.IdLugar LEFT JOIN TBL_COMUNAS C ON RA.IdComuna = C.IdComuna LEFT JOIN TBL_USUARIOS U ON RA.IdUsuarioCreacion = U.IdDocumento LEFT JOIN TBL_PERFILES P ON U.IdPerfil = P.IdPerfil WHERE TipoActividad = 'Reporte de Actividad' and YEAR(fecha) = "+ cboAnio.SelectedItem + " and MONTH(fecha) = " + cboMes.SelectedItem;
            }
            else
            {
                txtQueryReporteActividades.Text = "";
            }
        }

        private void btnExportarReporteActividades_Click(object sender, EventArgs e)
        {
            thr = new Thread(new ThreadStart(ExportFilesReporteActividades));
            thr.Start();
        }

        private void ExportFilesReporteActividades()
        {
            SqlDataReader reader;
            string path;
            string nameBD;
            string extension;
            string guidFile;
            int count = 0;
            try
            {
                path = txtOriginalPathReporteActividades.Text;
                if (path == string.Empty)
                {
                    MessageBox.Show("No hay ninguna ruta.");
                    return;
                }
                DirectoryInfo d = new DirectoryInfo(path);

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        command.CommandText = txtQueryReporteActividades.Text;
                        WriteTextSafeExportReporteActividades("Query Executing...");
                        reader = command.ExecuteReader();
                       // WriteTextSafeExportReporteActividades("Total files:" + reader.FieldCount.ToString());
                        if (rbReporteActividades.Checked)
                        {
                            while (reader.Read())
                            {
                                string tmp_PATH = txtDestinationPathReporteActividades.Text + "\\";
                                nameBD = reader["nombreArchivo"].ToString();
                                //extension = reader[txtExtensionField.Text].ToString();
                                guidFile = reader["Guid"].ToString();
                                tmp_PATH = tmp_PATH + reader["NombreComuna"].ToString();
                                //Crear Path de comuna
                                if (!Directory.Exists(tmp_PATH))
                                {
                                    Directory.CreateDirectory(tmp_PATH);
                                }
                                //Crear Path de Profesionales
                                if (!Directory.Exists(Path.Combine(tmp_PATH, reader["NombrePerfil"].ToString())))
                                {
                                    Directory.CreateDirectory(Path.Combine(tmp_PATH, reader["NombrePerfil"].ToString()));
                                }
                                
                                try
                                {
                                    File.Copy(txtOriginalPathReporteActividades.Text + "\\" + guidFile, Path.Combine(tmp_PATH, reader["NombrePerfil"].ToString()) + "\\" + nameBD);
                                    WriteTextSafeExportReporteActividades(nameBD + " -- OK");
                                }
                                catch (IOException exio)
                                {
                                    WriteTextSafeExportReporteActividades("Error: " + exio.Message + " Guid:" + guidFile);
                                }
                                catch (Exception ex)
                                {
                                    WriteTextSafeExportReporteActividades("Error: " + ex.Message + " Guid:" + guidFile);
                                }
                                count++;
                            }
                        }
                        if (rbAccionesEducativas.Checked)
                        {
                            while (reader.Read())
                            {
                                string tmp_PATH = txtDestinationPathReporteActividades.Text + "\\";
                                nameBD = reader["nombreArchivo"].ToString();
                                //extension = reader[txtExtensionField.Text].ToString();
                                guidFile = reader["Guid"].ToString();
                                tmp_PATH = tmp_PATH + reader["NombreComuna"].ToString();
                                //Crear Path de
                                if (!Directory.Exists(tmp_PATH))
                                {
                                    Directory.CreateDirectory(tmp_PATH);
                                }
                                //Crear Path de Categoría
                                if (!Directory.Exists(Path.Combine(tmp_PATH, reader["NombreCategoria"].ToString())))
                                {
                                    Directory.CreateDirectory(Path.Combine(tmp_PATH, reader["NombreCategoria"].ToString()));
                                }
                                
                                try
                                {
                                    File.Copy(txtOriginalPathReporteActividades.Text + "\\" + guidFile, Path.Combine(tmp_PATH, reader["NombreCategoria"].ToString()) + "\\" + nameBD);
                                    WriteTextSafeExportReporteActividades(nameBD + " -- OK");
                                }
                                catch (IOException exio)
                                {
                                    WriteTextSafeExportReporteActividades("Error: " + exio.Message + " Guid:" + guidFile);
                                }
                                catch (Exception ex)
                                {
                                    WriteTextSafeExportReporteActividades("Error: " + ex.Message + " Guid:" + guidFile);
                                }
                               
                                count++;
                            }
                        }
                        if (rbComprobantesVerificacion.Checked)
                        {
                            while (reader.Read())
                            {
                                string tmp_PATH = txtDestinationPathReporteActividades.Text + "\\";
                                nameBD = reader["nombreArchivo"].ToString();
                                //extension = reader[txtExtensionField.Text].ToString();
                                guidFile = reader["Guid"].ToString();
                                tmp_PATH = tmp_PATH + reader["NombreEapb"].ToString();
                                //Crear Path 
                                if (!Directory.Exists(tmp_PATH))
                                {
                                    Directory.CreateDirectory(tmp_PATH);
                                }

                                try
                                {
                                    File.Copy(txtOriginalPathReporteActividades.Text + "\\" + guidFile, Path.Combine(tmp_PATH,  nameBD));
                                    WriteTextSafeExportReporteActividades(nameBD + " -- OK");
                                }
                                catch (IOException exio)
                                {
                                    WriteTextSafeExportReporteActividades("Error: " + exio.Message + " Guid:" + guidFile);
                                }
                                catch (Exception ex)
                                {
                                    WriteTextSafeExportReporteActividades("Error: " + ex.Message + " Guid:" + guidFile);
                                }

                                count++;
                            }
                        }
                        if (rbPrevencionCovid.Checked)
                        {
                            while (reader.Read())
                            {
                                string tmp_PATH = txtDestinationPathReporteActividades.Text + "\\";
                                nameBD = reader["nombreArchivo"].ToString();
                                //extension = reader[txtExtensionField.Text].ToString();
                                guidFile = reader["Guid"].ToString();
                                tmp_PATH = tmp_PATH + reader["Actividad"].ToString();
                                //Crear Path 
                                if (!Directory.Exists(tmp_PATH))
                                {
                                    Directory.CreateDirectory(tmp_PATH);
                                }

                                try
                                {
                                    File.Copy(txtOriginalPathReporteActividades.Text + "\\" + guidFile, Path.Combine(tmp_PATH, nameBD));
                                    WriteTextSafeExportReporteActividades(nameBD + " -- OK");
                                }
                                catch (IOException exio)
                                {
                                    WriteTextSafeExportReporteActividades("Error: " + exio.Message + " Guid:" + guidFile);
                                }
                                catch (Exception ex)
                                {
                                    WriteTextSafeExportReporteActividades("Error: " + ex.Message + " Guid:" + guidFile);
                                }

                                count++;
                            }
                        }
                        if (rbNavidadSaludable.Checked)
                        {
                            while (reader.Read())
                            {
                                string tmp_PATH = txtDestinationPathReporteActividades.Text + "\\";
                                nameBD = reader["nombreArchivo"].ToString();
                                //extension = reader[txtExtensionField.Text].ToString();
                                guidFile = reader["Guid"].ToString();
                                tmp_PATH = tmp_PATH + reader["NombreComuna"].ToString();
                                //Crear Path 
                                if (!Directory.Exists(tmp_PATH))
                                {
                                    Directory.CreateDirectory(tmp_PATH);
                                }

                                try
                                {
                                    File.Copy(txtOriginalPathReporteActividades.Text + "\\" + guidFile, Path.Combine(tmp_PATH, nameBD));
                                    WriteTextSafeExportReporteActividades(nameBD + " -- OK");
                                }
                                catch (IOException exio)
                                {
                                    WriteTextSafeExportReporteActividades("Error: " + exio.Message + " Guid:" + guidFile);
                                }
                                catch (Exception ex)
                                {
                                    WriteTextSafeExportReporteActividades("Error: " + ex.Message + " Guid:" + guidFile);
                                }

                                count++;
                            }
                        }
                        WriteTextSafeExportReporteActividades("Exported Files:" + count);
                    }
                    connection.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void lbResultReporteActividades_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Control && e.KeyCode == Keys.C)
            {
                System.Text.StringBuilder copy_buffer = new System.Text.StringBuilder();
                foreach (object item in lbResultReporteActividades.SelectedItems)
                    copy_buffer.AppendLine(item.ToString());
                if (copy_buffer.Length > 0)
                    Clipboard.SetText(copy_buffer.ToString());
            }
        }

        private void rbComprobantesVerificacion_CheckedChanged(object sender, EventArgs e)
        {
            if (rbComprobantesVerificacion.Checked)
            {
               // txtQueryReporteActividades.Text = "select VD.Id_Verificacion, VD.NroDocumento + '-' + CAST(DAY(SVD.Fecha_Solicitud) as varchar) + CAST(MONTH(SVD.Fecha_Solicitud) as varchar) + cast(YEAR(SVD.Fecha_Solicitud) as varchar) + VD.Comprobante_FileExt as nombreArchivo,VD.Comprobante_Guid as [Guid] from TBL_SOLICITUDVERIFICACIONDERECHOS SVD JOIN TBL_VERIFICACIONDERECHOS VD ON SVD.Id_Verificacion = VD.Id_Verificacion where VD.SePuedeAtender = 'Si' AND YEAR(SVD.Fecha_Solicitud) = '" + cboAnio.SelectedItem +"' AND MONTH(SVD.Fecha_Solicitud) = '"+ cboMes.SelectedItem +"'";
                txtQueryReporteActividades.Text = "select TOP 10 VD.Id_Verificacion,EAPB.NombreEapb, VD.NroDocumento + VD.Comprobante_FileExt as nombreArchivo,VD.Comprobante_Guid as [Guid] from TBL_SOLICITUDVERIFICACIONDERECHOS SVD JOIN TBL_VERIFICACIONDERECHOS VD ON SVD.Id_Verificacion = VD.Id_Verificacion LEFT JOIN TBL_EAPB EAPB ON Vd.IdMaeEAPB = EAPB.IdMaeEAPB where VD.SePuedeAtender = 'Si' AND YEAR(SVD.Fecha_Solicitud) = '" + cboAnio.SelectedItem + "' AND MONTH(SVD.Fecha_Solicitud) = '" + cboMes.SelectedItem + "'";
            }
            else
            {
                txtQueryReporteActividades.Text = "";
            }
        }

        private void rbPrevencionCovid_CheckedChanged(object sender, EventArgs e)
        {
            if (rbPrevencionCovid.Checked)
            {
                txtQueryReporteActividades.Text = "select TOP 10 APC.IdActividadPrevencion, APC.Actividad, CAST(APC.IdActividadPrevencion as varchar) + APC.Documento_FileExt as nombreArchivo, APC.Documento_Guid as [Guid] from TBL_ACTIVIDADPREVENCIONCOVID APC WHERE YEAR(APC.FechaActividad) = '"+ cboAnio.SelectedItem + "' AND MONTH(APC.FechaActividad) = '"+ cboMes.SelectedItem + "'";
            }
            else
            {
                txtQueryReporteActividades.Text = "";
            }
        }

        private void rbNavidadSaludable_CheckedChanged(object sender, EventArgs e)
        {
            if (rbNavidadSaludable.Checked)
            {
                txtQueryReporteActividades.Text = "select CF.IdCaracterizacionFamiliar as codigo,  CAST(CF.IdCaracterizacionFamiliar as varchar) + CF.NavidadSaludable_Ext as nombreArchivo,C.NombreComuna,CF.NavidadSaludable_Guid as [Guid] from TBL_CARACTERIZACIONFAMILIAR CF JOIN TBL_COMUNAS C ON CF.IdComuna = C.IdComuna where CF.NavidadSaludable = 'Si' AND YEAR(CF.FechaModificacion) = '"+ cboAnio.SelectedItem + "' AND MONTH(CF.FechaModificacion) = '"+ cboMes.SelectedItem + "' UNION ALL select NS.Id_NavidadSaludable as codigo,  CAST(NS.Id_NavidadSaludable as varchar) + ns.NavidadSaludable_Ext as nombreArchivo, C.NombreComuna, Ns.NavidadSaludable_Guid as [Guid] from TBL_NAVIDADSALUDABLE NS JOIN TBL_PERSONAS P ON P.IdDocumento = Ns.IdDocumento JOIN TBL_COMUNAS C ON C.IdComuna = P.IdComuna   WHERe NS.NavidadSaludable_FileName IS NOT NULL AND YEAR(NS.FechaCreacion) = '"+ cboAnio.SelectedItem + "' AND MONTH(NS.FechaCreacion) = '"+ cboMes.SelectedItem + "'";
            }
            else
            {
                txtQueryReporteActividades.Text = "";
            }
        }
    }
}
