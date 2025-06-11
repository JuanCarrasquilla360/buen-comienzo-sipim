using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Administracion.To;
using System.Web.UI.WebControls;

namespace BuenComienzo.Core.Operacion
{
    public class SeguimientoDeficitNutricional
    {
        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public string Error
        {
            get
            {
                return strError;
            }
        }

        public DataTable ConsultarSeguimientoDeficitNutricional(string idCoordinador, string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_SEGUIMIENTODEFICITNUTRICIONAL", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public string InsertarSeguimientoDeficitNutricional(string numeroIdentificacion, DateTime fechaHora,
                              string idTipoAtencion, string idCicloVital, string peso, string talla, string perimetroBraquial, string perimetroCefalico,
                              string semanasGestacion, string dXNutricional, string tallaEdad, string cuantosSeguimientosRealizado, string remisionFisica,
                              string remisionEfectivaAtencionSalud, string describaAtencionesRecibidas, string notificaNutrirParaSanar, string accionesImplementadas,
                              string huboHospitalizacion, string recibeComplementacionEntidadSalud, string queComplementacionRecibe, string cualOtraComplementacion,
                              string diligenciamientoSivigila, string recibeRacionAlimentaria365, string recibeRacionNutrirParaSanar, string queTipoRacionNutrirParaSanarRecibe,
                              string clasificacionELCSA, string cambioSuEstadoNutricional, string nuevoDiagnostico, string aspectosAlimentarios, string aspectosBioquimicos,
                              string aspectosClinicos, string aspectosEconomicos, string aspectosFamiliares, string aspectosPsicosociales, string devolucionFamiliaAspectosAbordadosNutricional,
                              string socializacionSeguimientoEquipo, string activacionRutaVulneracionDerechos, string especificarCualVulneracion, string describaAccionesRealizadas,
                              string observacionesGenerales, string compromisoEstablecidoConFamilia, string nombreArchivoGuid, string nombreArchivo, string casoCerrado,
                              string idMatricula, string idCoordinador, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaHora", Valor = fechaHora, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdTipoAtencion", Valor = idTipoAtencion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCicloVital", Valor = string.IsNullOrEmpty(idCicloVital) ? null : idCicloVital, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Peso", Valor = string.IsNullOrEmpty(peso) ? null : peso.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Talla", Valor = string.IsNullOrEmpty(talla) ? null : talla.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PerimetroBraquial", Valor = string.IsNullOrEmpty(perimetroBraquial) ? null : perimetroBraquial.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PerimetroCefalico", Valor = string.IsNullOrEmpty(perimetroCefalico) ? null : perimetroCefalico.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SemanasGestacion", Valor = string.IsNullOrEmpty(semanasGestacion) ? null : semanasGestacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DXNutricional", Valor = string.IsNullOrEmpty(dXNutricional) ? null : dXNutricional, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@TallaEdad", Valor = string.IsNullOrEmpty(tallaEdad) ? null : tallaEdad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@CuantosSeguimientosRealizado", Valor = cuantosSeguimientosRealizado, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@RemisionFisica", Valor = remisionFisica, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@RemisionEfectivaAtencionSalud", Valor = string.IsNullOrEmpty(remisionEfectivaAtencionSalud) ? null : remisionEfectivaAtencionSalud, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DescribaAtencionesRecibidas", Valor = string.IsNullOrEmpty(describaAtencionesRecibidas) ? null : describaAtencionesRecibidas, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NotificaNutrirParaSanar", Valor = notificaNutrirParaSanar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AccionesImplementadas", Valor = string.IsNullOrEmpty(accionesImplementadas) ? null : accionesImplementadas, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@HuboHospitalizacion", Valor = huboHospitalizacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@RecibeComplementacionEntidadSalud", Valor = string.IsNullOrEmpty(recibeComplementacionEntidadSalud) ? null : recibeComplementacionEntidadSalud, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@QueComplementacionRecibe", Valor = string.IsNullOrEmpty(queComplementacionRecibe) ? null : queComplementacionRecibe, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@CualOtraComplementacion", Valor = string.IsNullOrEmpty(cualOtraComplementacion) ? null : cualOtraComplementacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DiligenciamientoSivigila", Valor = diligenciamientoSivigila, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@RecibeRacionAlimentaria365", Valor = recibeRacionAlimentaria365, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@RecibeRacionNutrirParaSanar", Valor = recibeRacionNutrirParaSanar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@QueTipoRacionNutrirParaSanarRecibe", Valor = string.IsNullOrEmpty(queTipoRacionNutrirParaSanarRecibe) ? null : queTipoRacionNutrirParaSanarRecibe, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@ClasificacionELCSA", Valor = clasificacionELCSA, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@CambioSuEstadoNutricional", Valor = cambioSuEstadoNutricional, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NuevoDiagnostico", Valor = string.IsNullOrEmpty(nuevoDiagnostico) ? null : nuevoDiagnostico, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AspectosAlimentarios", Valor = string.IsNullOrEmpty(aspectosAlimentarios) ? null : aspectosAlimentarios, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AspectosBioquimicos", Valor = string.IsNullOrEmpty(aspectosBioquimicos) ? null : aspectosBioquimicos, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AspectosClinicos", Valor = string.IsNullOrEmpty(aspectosClinicos) ? null : aspectosClinicos, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AspectosEconomicos", Valor = string.IsNullOrEmpty(aspectosEconomicos) ? null : aspectosEconomicos, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AspectosFamiliares", Valor = string.IsNullOrEmpty(aspectosFamiliares) ? null : aspectosFamiliares, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AspectosPsicosociales", Valor = string.IsNullOrEmpty(aspectosPsicosociales) ? null : aspectosPsicosociales, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DevolucionFamiliaAspectosAbordadosNutricional", Valor = string.IsNullOrEmpty(devolucionFamiliaAspectosAbordadosNutricional) ? null : devolucionFamiliaAspectosAbordadosNutricional, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SocializacionSeguimientoEquipo", Valor = socializacionSeguimientoEquipo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@ActivacionRutaVulneracionDerechos", Valor = activacionRutaVulneracionDerechos, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@EspecificarCualVulneracion", Valor = string.IsNullOrEmpty(especificarCualVulneracion) ? null : especificarCualVulneracion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DescribaAccionesRealizadas", Valor = string.IsNullOrEmpty(describaAccionesRealizadas) ? null : describaAccionesRealizadas, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@ObservacionesGenerales", Valor = string.IsNullOrEmpty(observacionesGenerales) ? null : observacionesGenerales, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@CompromisoEstablecidoConFamilia", Valor = string.IsNullOrEmpty(compromisoEstablecidoConFamilia) ? null : compromisoEstablecidoConFamilia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NombreArchivoGuid", Valor = string.IsNullOrEmpty(nombreArchivoGuid) ? null : nombreArchivoGuid, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NombreArchivo", Valor = string.IsNullOrEmpty(nombreArchivo) ? null : nombreArchivo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@CasoCerrado", Valor = casoCerrado, Tipo = typeof(byte) },
                    new Parametro { NombreParametro = "@IdMatricula", Valor = idMatricula, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                resp = objBd.ejecutarProcedimiento("dbop_AddTBL_SEGUIMIENTODEFICITNUTRICIONAL", parametros, "IdSeguimientoDeficitNutricional", DbType.Int32, 10);
                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ActualizarSeguimientoDeficitNutricional(string idSeguimientoDeficitNutricional, string numeroIdentificacion, DateTime fechaHora,
                                                    string idTipoAtencion, string idCicloVital, string peso, string talla, string perimetroBraquial, string dXNutricional,
                                                    /*string desviacionEstandar, string IMC, string dXNutricional, string dXEnfermedadBase, string enfermedades,
                                                    string signosFisicosCarenciales, string idInseguridadAlimentaria, string idAccesoServiciosPublicos,
                                                    string idAccesoServiciosSalud, string condicionesVivienda, string aspectosPsicosocialesVulneracionDerechos,
                                                    string idLactanciaMaterna, string accionesRealizadas,*/ string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdSeguimientoDeficitNutricional", Valor = (idSeguimientoDeficitNutricional), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaHora", Valor = fechaHora, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdTipoAtencion", Valor = idTipoAtencion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCicloVital", Valor = string.IsNullOrEmpty(idCicloVital) ? null : idCicloVital, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Peso", Valor = string.IsNullOrEmpty(peso) ? null : peso.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Talla", Valor = string.IsNullOrEmpty(talla) ? null : talla.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PerimetroBraquial", Valor = string.IsNullOrEmpty(perimetroBraquial) ? null : perimetroBraquial.Replace(",", "."), Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@DesviacionEstandar", Valor = string.IsNullOrEmpty(desviacionEstandar) ? null : desviacionEstandar.Replace(",", "."), Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@IMC", Valor = string.IsNullOrEmpty(IMC) ? null : IMC.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DXNutricional", Valor = string.IsNullOrEmpty(dXNutricional) ? null : dXNutricional, Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@DXEnfermedadBase", Valor = dXEnfermedadBase, Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@Enfermedades", Valor = string.IsNullOrEmpty(enfermedades) ? null : enfermedades, Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@SignosFisicosCarenciales", Valor = signosFisicosCarenciales, Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@IdInseguridadAlimentaria", Valor = idInseguridadAlimentaria, Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@IdAccesoServiciosPublicos", Valor = idAccesoServiciosPublicos, Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@IdAccesoServiciosSalud", Valor = idAccesoServiciosSalud, Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@CondicionesVivienda", Valor = condicionesVivienda, Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@AspectosPsicosocialesVulneracionDerechos", Valor = aspectosPsicosocialesVulneracionDerechos, Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@IdLactanciaMaterna", Valor = string.IsNullOrEmpty(idLactanciaMaterna) ? null : idLactanciaMaterna, Tipo = typeof(string) },
                    //new Parametro { NombreParametro = "@AccionesRealizadas", Valor = accionesRealizadas, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_SEGUIMIENTODEFICITNUTRICIONAL", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ObtenerSeguimientoDeficitNutricional(string idSeguimientoDeficitNutricional)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdSeguimientoDeficitNutricional", Valor = (idSeguimientoDeficitNutricional), Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_SEGUIMIENTODEFICITNUTRICIONAL", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool EliminarSeguimientoDeficitNutricional(string idSeguimientoDeficitNutricional)
        {
            try
            {
                Object resp;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdSeguimientoDeficitNutricional", Valor = idSeguimientoDeficitNutricional, Tipo = typeof(string) },
                };

                resp = objBd.ejecutarProcedimiento("dbop_DeleteTBL_SEGUIMIENTODEFICITNUTRICIONAL", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

    }
}
