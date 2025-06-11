using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Data;
using System.Reflection;
using BuenComienzo.Core.Administracion;
using System.Collections;
using System.Globalization;

namespace BuenComienzo.Core
{
    public enum TipoMensaje
    {
        Error,
        Exito,
        Advertencia
    }
    public static class Utilidades
    {
        public static void ListaLigada(HtmlSelect ddlListaPadre, HtmlSelect ddlListaHijo, string c1, string c2, string c3)
        {
            DataTable dtDatosListaHijo = (DataTable)ddlListaHijo.DataSource;

            if (ddlListaPadre.SelectedIndex > 0 && ddlListaHijo.SelectedIndex > 0)
            {
                string valor = ddlListaHijo.Value;
                ddlListaHijo.DataSource = (from datos in dtDatosListaHijo.AsEnumerable()
                                           where datos[c2].ToString().Equals(ddlListaHijo.Value)
                                           orderby datos[c3]
                                           select datos).CopyToDataTable();

                ddlListaHijo.DataBind();
                ddlListaHijo.Value = valor;
            }
            else
                CargarLista(ddlListaHijo, null, "", "", true);

            string script = "var $ddlHijo = $('select[id$=" + ddlListaHijo.ClientID + "]');\n";

            script += "var valor = this.options[this.selectedIndex].value;";

            script += "var datos = [\n";

            foreach (DataRow fila in dtDatosListaHijo.Rows)
            {
                script += "['" + fila[c1].ToString() + "','" + fila[c2].ToString() + "','" + fila[c3].ToString() + "'],";
            }

            script = script.Substring(0, script.Length - 1);

            script += "\n];\n";

            script += "$ddlHijo.empty();\n";
            script += "var arr = $.grep(datos,\n";
            script += "function (n) {\n";
            script += "return (valor == n[0]);\n";
            script += "});\n";
            script += "if (arr.length > 0) {\n";
            script += "$ddlHijo.append('<option value=\\'\\'>--Seleccione--</option>');\n";
            script += "$.each(arr, function () {\n";
            script += "$ddlHijo.append('<option value=\\'' + this[1] + '\\'>' + this[2] + '</option>');\n";
            script += "$ddlHijo.get(0).selectedIndex = 0;\n";
            script += "});\n";


            script += "var opciones = $('#" + ddlListaHijo.ClientID + " option');\n";
            script += "var seleccionado = $('#" + ddlListaHijo.ClientID + "').val();\n";
            script += "opciones.sort(function (a, b) {\n";
            script += "if (a.text > b.text) return 1;\n";
            script += "else if (a.text < b.text) return -1;\n";
            script += "else return 0\n";
            script += "});\n";
            script += "$('#" + ddlListaHijo.ClientID + "').empty().append(opciones);\n";
            script += "$('#" + ddlListaHijo.ClientID + "').val(seleccionado);\n";
            script += "\n";
            script += "} else {\n";
            script += "$ddlHijo.append('<option value=\\'\\'>--Seleccione--</option>');\n";
            script += "}\n";

            ddlListaPadre.Attributes.Add("onchange", script);
        }

        public static int ToInt(string toParse)
        {
            int result;
            if (int.TryParse(toParse, out result)) return result;

            return result;
        }

        public static string Mayuscula(string value)
        {
            // Check for empty string.
            if (string.IsNullOrEmpty(value))
                return null;
            
            value = value.ToLower();
            // Return char and concat substring.
            return char.ToUpper(value[0]) + value.Substring(1);
        }

        public static string Mayusculas(string value)
        {
            if (!string.IsNullOrEmpty(value))
            {
                char[] array = value.ToLower().ToCharArray();
                // Handle the first letter in the string.
                if (array.Length >= 1)
                {
                    if (char.IsLower(array[0]))
                    {
                        array[0] = char.ToUpper(array[0]);
                    }
                }
                // Scan through the letters, checking for spaces.
                // ... Uppercase the lowercase letters following spaces.
                for (int i = 1; i < array.Length; i++)
                {
                    if (array[i - 1] == ' ')
                    {
                        if (char.IsLower(array[i]))
                        {
                            array[i] = char.ToUpper(array[i]);
                        }
                    }
                }

                return new string(array);
            }
            else
                return null;
        }

        public static bool TienePermiso(int idPerfil, string objeto)
        {
            Seguridad objSeguridad = new Seguridad();
            return objSeguridad.TienePermiso(idPerfil, objeto);
        }

        public static void CargarLista(HtmlSelect ddlLista, DataTable dtDatos, string cValor, string cText, bool seleccione)
        {
            ddlLista.Items.Clear();

            if (dtDatos != null)
            {
                ddlLista.DataSource = dtDatos;
                ddlLista.DataTextField = cText;
                ddlLista.DataValueField = cValor;
                ddlLista.DataBind();
            }

            if (seleccione)
            {
                ListItem nuevaFila = new ListItem("--Seleccione--", "");
                ddlLista.Items.Insert(0, nuevaFila);
            }
        }

        public static void CargarListaWhitObjectList (HtmlSelect ddlLista, object Datos, string cValor, string cText, bool seleccione) 
        {
            ddlLista.Items.Clear();

            if (Datos != null)
            {
                ddlLista.DataSource = Datos;
                ddlLista.DataTextField = cText;
                ddlLista.DataValueField = cValor;
                ddlLista.DataBind();
            }

            if (seleccione)
            {
                ListItem nuevaFila = new ListItem("--Seleccione--", "");
                ddlLista.Items.Insert(0, nuevaFila);
            }
        }

        public static void CargarLista(DropDownList ddlLista, DataTable dtDatos, string cValor, string cText, bool seleccione)
        {
            if (dtDatos != null)
            {
                ddlLista.DataSource = dtDatos;
                ddlLista.DataTextField = cText;
                ddlLista.DataValueField = cValor;
                ddlLista.DataBind();
            }

            if (seleccione)
            {
                ListItem nuevaFila = new ListItem("--Seleccione--", "");
                ddlLista.Items.Insert(0, nuevaFila);
            }
        }

        public static void CerrarPopup(Page form)
        {
            form.ClientScript.RegisterClientScriptBlock(form.GetType(), "CerrarPopup", "CloseModalBox();", true);
        }

        public static void MostrarMensaje(string mensaje, TipoMensaje tipoMensaje, bool cerrarPopup)
        {
            HttpContext.Current.Session[VariablesSession.CerrarPopup] = cerrarPopup;
            HttpContext.Current.Session[VariablesSession.Mensaje] = mensaje;
            HttpContext.Current.Session[VariablesSession.TipoMensaje] = tipoMensaje;
        }

        public static void MostrarMensajeModal(string mensaje, TipoMensaje tipoMensaje, bool cerrarPopup, bool habilitarBotones)
        {
            HttpContext.Current.Session[VariablesSession.CerrarPopup] = cerrarPopup;
            HttpContext.Current.Session[VariablesSession.Mensaje] = mensaje;
            HttpContext.Current.Session[VariablesSession.TipoMensaje] = tipoMensaje;
            HttpContext.Current.Session[VariablesSession.MensajeModal] = true;
            HttpContext.Current.Session[VariablesSession.HabilitarBotones] = habilitarBotones;
        }

        public static string Encriptar(string cadena)
        {
            string result = string.Empty;
            byte[] encriptado = System.Text.Encoding.Unicode.GetBytes(cadena);
            result = Convert.ToBase64String(encriptado);
            return result;
        }

        /// Esta función desencripta la cadena que le envíamos en el parámentro de entrada.
        public static string DesEncriptar(string cadena)
        {
            string result = string.Empty;
            byte[] desEncriptado = Convert.FromBase64String(cadena);
            //result = System.Text.Encoding.Unicode.GetString(decryted, 0, decryted.ToArray().Length);
            result = System.Text.Encoding.Unicode.GetString(desEncriptado);
            return result;
        }

        /// <summary> 
        /// Convert Data Table To List of Type T 
        /// </summary> 
        /// <typeparam name="T">Target Class to convert data table to List of T </typeparam> 
        /// <param name="datatable">Data Table you want to convert it</param> 
        /// <returns>List of Target Class</returns> 
        public static List<T> ToList<T>(this DataTable datatable) where T : new()
        {
            List<T> Temp = new List<T>();
            try
            {
                List<string> columnsNames = new List<string>();
                foreach (DataColumn DataColumn in datatable.Columns)
                    columnsNames.Add(DataColumn.ColumnName);
                Temp = datatable.AsEnumerable().ToList().ConvertAll<T>(row => getObject<T>(row, columnsNames));
                return Temp;
            }
            catch { return Temp; }
        }

        public static List<T> ToListof<T>(this DataTable dt)
        {
            const BindingFlags flags = BindingFlags.Public | BindingFlags.Instance;
            var columnNames = dt.Columns.Cast<DataColumn>()
                .Select(c => c.ColumnName)
                .ToList();
            var objectProperties = typeof(T).GetProperties(flags);
            var targetList = dt.AsEnumerable().Select(dataRow =>
            {
                var instanceOfT = Activator.CreateInstance<T>();

                foreach (var properties in objectProperties.Where(properties => columnNames.Contains(properties.Name) && dataRow[properties.Name] != DBNull.Value))
                {
                    properties.SetValue(instanceOfT, dataRow[properties.Name], null);
                }
                return instanceOfT;
            }).ToList();

            return targetList;
        }

        public static T getObject<T>(DataRow row, List<string> columnsName) where T : new()
        {
            T obj = new T();
            try
            {
                string columnname = "";
                string value = "";
                PropertyInfo[] Properties; Properties = typeof(T).GetProperties();
                foreach (PropertyInfo objProperty in Properties)
                {
                    columnname = columnsName.Find(name => name.ToLower() == objProperty.Name.ToLower());
                    if (!string.IsNullOrEmpty(columnname))
                    {
                        value = row[columnname].ToString();
                        if (!string.IsNullOrEmpty(value))
                        {
                            if (Nullable.GetUnderlyingType(objProperty.PropertyType) != null)
                            {
                                if (objProperty.PropertyType == typeof(DateTime?))
                                {
                                    DateTime parsedDate;
                                    if (DateTime.TryParseExact(row[columnname].ToString().Replace("%", ""), "dd/MM/yyyy", null, DateTimeStyles.None, out parsedDate))
                                        value = parsedDate.ToString();
                                    else
                                        value = row[columnname].ToString().Replace("$", "").Replace(",", "");
                                }
                                else
                                    value = row[columnname].ToString().Replace("$", "").Replace(",", "");

                                objProperty.SetValue(obj, Convert.ChangeType(value, Type.GetType(Nullable.GetUnderlyingType(objProperty.PropertyType).ToString())), null);
                            }
                            else
                            {
                                if (objProperty.PropertyType == typeof(DateTime))
                                {
                                    DateTime parsedDate;
                                    if (DateTime.TryParseExact(row[columnname].ToString().Replace("%", ""), "dd/MM/yyyy", null, DateTimeStyles.None, out parsedDate))
                                        value = parsedDate.ToString();
                                    else
                                        value = row[columnname].ToString().Replace("%", "");
                                }
                                else
                                    value = row[columnname].ToString().Replace("%", "");

                                objProperty.SetValue(obj, Convert.ChangeType(value, Type.GetType(objProperty.PropertyType.ToString())), null);
                            }
                        }
                    }
                } return obj;
            }
            catch { return obj; }
        }

        public delegate object[] CreateRowDelegate<T>(T t);


        public static void SeleccionarItem(string item, HtmlSelect lista)
        {
            if (!string.IsNullOrEmpty(item))
            {
                ListItem listaItem = lista.Items.FindByValue(item);
                if (listaItem != null)
                    listaItem.Selected = true;
            }
        }

        public static void SeleccionarItemTexto(string item, HtmlSelect lista)
        {
            if (!string.IsNullOrEmpty(item))
            {
                ListItem listaItem = lista.Items.FindByText(item);
                if (listaItem != null)
                    listaItem.Selected = true;
            }
        }

        public static string AnoVigencia()
        {
            if (HttpContext.Current.Session[VariablesSession.AnoVigencia] != null)
                return HttpContext.Current.Session[VariablesSession.AnoVigencia].ToString();
            else
                //return "2015";
                return DateTime.Now.Year.ToString();
        }

        public static bool IsNumeric(string s)
        {
            int output;
            return int.TryParse(s, out output);
        }

        public static bool IsDecimal(string s)
        {
            decimal output;
            return decimal.TryParse(s, out output);
        }

        public static bool IsDate(string s, string formato)
        {
            DateTime output;
            return DateTime.TryParseExact(s, formato, CultureInfo.InvariantCulture, DateTimeStyles.None, out output);
        }
    }
}
