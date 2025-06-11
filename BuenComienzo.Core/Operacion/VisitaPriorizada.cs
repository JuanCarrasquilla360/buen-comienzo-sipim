using BuenComienzo.AccesoDatos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Operacion
{
    public class VisitaPriorizada
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

        public DataTable ConsultarVisitasPriorizadas(string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_VISITAPRIORIZADA", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataSet ObtenerVisitaPriorizada(int idVisitaPriorizada)
        {
            try
            {
                DataSet dsDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdVisitaPriorizada", Valor = idVisitaPriorizada, Tipo = typeof(int) });

                dsDatos = objBd.ejecutarProcedimientoDS("dbop_Get_VisitaPriorizadaALL", parametros);

                return dsDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public int Insertar(string idDocumento, DateTime? Fecha, int IdMaeVisitaPrioritaria, string IdDXCIE10,
            string HaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida, string EdadPrimerConsumo, string HaConsumidoAlgunOtroTipoSustanciaAlteraEstadoAnimoConciencia,
            string HaVueltoAConsumir, string ConQueFrecuencia, string PresentaIdeasRecurrentesDeseoMorirQuitarseLaVida, string EnFamiliaOCirculoCercanoHaMuertoPorSuicidio,
            string PresentaSintomasDepresion, string AlgunaVezHaTenidoIntentoSuicidio, string TuvoIntentoSuicidioReciente, string FueAtendidoEnUrgenicasPorIntentoSuicidioReciente,
            string OyeVocesSinSaberDondeVienenOQueOtrasPersonasNoPuedenOir, string EsVictimaConflictoArmado, string AlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima,
            string PresentaOHaPresentadoUltimoMesAlgunSintoma, string AlInteriorGrupoFamiliarAlgunMiembro, string Observaciones,string HabilidadesParaLaVida, string TipoOrientacion,
            string SeguimientoIntervenciones, string Desarrollo, string Logros, DateTime? FechaIntervencionBreve, string IdUsuarioCreacion, ref int intError, ref string strError)
        {
            try
            {
                int idVisitaPriorizada = 0;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Fecha", Valor = Fecha, Tipo = typeof(DateTime) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeVisitaPrioritaria", Valor = IdMaeVisitaPrioritaria, Tipo = typeof(byte) });
                parametros.Add(new Parametro { NombreParametro = "@IdDXCIE10", Valor = IdDXCIE10, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@HaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida", Valor = HaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@EdadPrimerConsumo", Valor = EdadPrimerConsumo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@HaConsumidoAlgunOtroTipoSustanciaAlteraEstadoAnimoConciencia", Valor = HaConsumidoAlgunOtroTipoSustanciaAlteraEstadoAnimoConciencia, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@HaVueltoAConsumir", Valor = HaVueltoAConsumir, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@ConQueFrecuencia", Valor = ConQueFrecuencia, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PresentaIdeasRecurrentesDeseoMorirQuitarseLaVida", Valor = PresentaIdeasRecurrentesDeseoMorirQuitarseLaVida, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@EnFamiliaOCirculoCercanoHaMuertoPorSuicidio", Valor = EnFamiliaOCirculoCercanoHaMuertoPorSuicidio, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PresentaSintomasDepresion", Valor = PresentaSintomasDepresion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@AlgunaVezHaTenidoIntentoSuicidio", Valor = AlgunaVezHaTenidoIntentoSuicidio, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@TuvoIntentoSuicidioReciente", Valor = TuvoIntentoSuicidioReciente, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FueAtendidoEnUrgenicasPorIntentoSuicidioReciente", Valor = FueAtendidoEnUrgenicasPorIntentoSuicidioReciente, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@OyeVocesSinSaberDondeVienenOQueOtrasPersonasNoPuedenOir", Valor = OyeVocesSinSaberDondeVienenOQueOtrasPersonasNoPuedenOir, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@EsVictimaConflictoArmado", Valor = EsVictimaConflictoArmado, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@AlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima", Valor = AlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PresentaOHaPresentadoUltimoMesAlgunSintoma", Valor = PresentaOHaPresentadoUltimoMesAlgunSintoma, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@AlInteriorGrupoFamiliarAlgunMiembro", Valor = AlInteriorGrupoFamiliarAlgunMiembro, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Observaciones", Valor = Observaciones, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@HabilidadesParaLaVida", Valor = HabilidadesParaLaVida, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@TipoOrientacion", Valor = TipoOrientacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SeguimientoIntervenciones", Valor = SeguimientoIntervenciones, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Desarrollo", Valor = Desarrollo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Logros", Valor = Logros, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaIntervencionBreve", Valor = FechaIntervencionBreve, Tipo = typeof(DateTime) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = IdUsuarioCreacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@OUT_intError", Valor = intError, Tipo = typeof(int), IsOutput = true });
                parametros.Add(new Parametro { NombreParametro = "@OUT_strError", Valor = strError, Tipo = typeof(string), IsOutput = true });
                parametros.Add(new Parametro { NombreParametro = "@idVisitaPriorizada", Valor = idVisitaPriorizada, Tipo = typeof(int), IsOutput = true });

                if (objBd.ejecutarProcedimientoIUD("dbop_AddTBL_VISITAPRIORIZADA", parametros, ref intError, ref strError, "@idVisitaPriorizada", ref idVisitaPriorizada))
                {
                    return idVisitaPriorizada;
                }
                else
                {
                    return 0;
                }

            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return 0;
            }
        }

        public int Actualizar(int IdVisitraPriorizada, string idDocumento, DateTime? Fecha, int IdMaeVisitaPrioritaria, string IdDXCIE10,
            string HaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida, string EdadPrimerConsumo, string HaConsumidoAlgunOtroTipoSustanciaAlteraEstadoAnimoConciencia,
            string HaVueltoAConsumir, string ConQueFrecuencia, string PresentaIdeasRecurrentesDeseoMorirQuitarseLaVida, string EnFamiliaOCirculoCercanoHaMuertoPorSuicidio,
            string PresentaSintomasDepresion, string AlgunaVezHaTenidoIntentoSuicidio, string TuvoIntentoSuicidioReciente, string FueAtendidoEnUrgenicasPorIntentoSuicidioReciente,
            string OyeVocesSinSaberDondeVienenOQueOtrasPersonasNoPuedenOir, string EsVictimaConflictoArmado, string AlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima,
            string PresentaOHaPresentadoUltimoMesAlgunSintoma, string AlInteriorGrupoFamiliarAlgunMiembro, string Observaciones, string HabilidadesParaLaVida, string TipoOrientacion,
            string SeguimientoIntervenciones, string Desarrollo, string Logros, DateTime? FechaIntervencionBreve, string IdUsuarioModificacion, ref int intError, ref string strError)
        {
            try
            {
                DateTime fechaModificacion = DateTime.Now;

                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdVisitraPriorizada", Valor = IdVisitraPriorizada, Tipo = typeof(int) });
                parametros.Add(new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Fecha", Valor = Fecha, Tipo = typeof(DateTime) });
                parametros.Add(new Parametro { NombreParametro = "@IdMaeVisitaPrioritaria", Valor = IdMaeVisitaPrioritaria, Tipo = typeof(byte) });
                parametros.Add(new Parametro { NombreParametro = "@IdDXCIE10", Valor = IdDXCIE10, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@HaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida", Valor = HaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@EdadPrimerConsumo", Valor = EdadPrimerConsumo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@HaConsumidoAlgunOtroTipoSustanciaAlteraEstadoAnimoConciencia", Valor = HaConsumidoAlgunOtroTipoSustanciaAlteraEstadoAnimoConciencia, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@HaVueltoAConsumir", Valor = HaVueltoAConsumir, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@ConQueFrecuencia", Valor = ConQueFrecuencia, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PresentaIdeasRecurrentesDeseoMorirQuitarseLaVida", Valor = PresentaIdeasRecurrentesDeseoMorirQuitarseLaVida, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@EnFamiliaOCirculoCercanoHaMuertoPorSuicidio", Valor = EnFamiliaOCirculoCercanoHaMuertoPorSuicidio, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PresentaSintomasDepresion", Valor = PresentaSintomasDepresion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@AlgunaVezHaTenidoIntentoSuicidio", Valor = AlgunaVezHaTenidoIntentoSuicidio, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@TuvoIntentoSuicidioReciente", Valor = TuvoIntentoSuicidioReciente, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FueAtendidoEnUrgenicasPorIntentoSuicidioReciente", Valor = FueAtendidoEnUrgenicasPorIntentoSuicidioReciente, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@OyeVocesSinSaberDondeVienenOQueOtrasPersonasNoPuedenOir", Valor = OyeVocesSinSaberDondeVienenOQueOtrasPersonasNoPuedenOir, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@EsVictimaConflictoArmado", Valor = EsVictimaConflictoArmado, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@AlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima", Valor = AlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@PresentaOHaPresentadoUltimoMesAlgunSintoma", Valor = PresentaOHaPresentadoUltimoMesAlgunSintoma, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@AlInteriorGrupoFamiliarAlgunMiembro", Valor = AlInteriorGrupoFamiliarAlgunMiembro, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Observaciones", Valor = Observaciones, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@HabilidadesParaLaVida", Valor = HabilidadesParaLaVida, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@TipoOrientacion", Valor = TipoOrientacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@SeguimientoIntervenciones", Valor = SeguimientoIntervenciones, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Desarrollo", Valor = Desarrollo, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@Logros", Valor = Logros, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@FechaIntervencionBreve", Valor = FechaIntervencionBreve, Tipo = typeof(DateTime) });
                parametros.Add(new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = IdUsuarioModificacion, Tipo = typeof(string) });
                parametros.Add(new Parametro { NombreParametro = "@OUT_intError", Valor = intError, Tipo = typeof(int), IsOutput = true });
                parametros.Add(new Parametro { NombreParametro = "@OUT_strError", Valor = strError, Tipo = typeof(string), IsOutput = true });
                parametros.Add(new Parametro { NombreParametro = "@idVisitaPriorizada_OUT", Valor = IdVisitraPriorizada, Tipo = typeof(int), IsOutput = true });

                if (objBd.ejecutarProcedimientoIUD("dbop_UpdateTBL_VISITAPRIORIZADA", parametros, ref intError, ref strError, "@idVisitaPriorizada_OUT", ref IdVisitraPriorizada))
                {
                    return IdVisitraPriorizada;
                }
                else
                {
                    return 0;
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                
                strError = ex.Message;
                return 0;
            }
        }

    }
}
