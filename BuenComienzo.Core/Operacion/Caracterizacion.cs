using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Administracion.To;
using System.Security.Cryptography;
using System.Security.Policy;

namespace BuenComienzo.Core.Operacion
{
    public class Caracterizacion
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

        public DataTable ConsultarCaracterizacion(string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_CARACTERIZACION", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarParticipantesEncuentro(string idEncuentroEducativo, string idProgramacionActividades, string extemporaneo)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdProgramacionActividades", Valor = idProgramacionActividades, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdEncuentroEducativo", Valor = idEncuentroEducativo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Extemporaneo", Valor = extemporaneo, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_PARTICIPANTESENCUENTRO", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ConsultarParticipantesEntregaPaquete(string idCoordinador, string idEntregaPaquete, string idUba, string extemporaneo)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUba", Valor = idUba, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdEntregaPaquete", Valor = idEntregaPaquete, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Extemporaneo", Valor = extemporaneo, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_PARTICIPANTESENTREGAPAQUETE", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public string ObtenerCicloVitalParticipante(string numeroDocumento)
        {
            try
            {
                Object resp;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@NumeroDocumento", Valor = numeroDocumento, Tipo = typeof(string) }
                };

                resp = objBd.ejecutarProcedimiento("dbop_Get_CICLOVITALPARTICIPANTE", parametros, "IdCicloVital", DbType.AnsiString, 10);
                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool InsertarCaracterizacion(DateTime fechaRegistroCaracterizacion, string idCuentame, string idTipoIdentificacion, string numeroIdentificacion,
                                                string nombreFamiResponsable, string primerNombre, string segundoNombre, string primerApellido, string segundoApellido,
                                                DateTime fechaNacimiento, string idSexo, string idNacionalidad, string telefono, string celular,
                                                string direccion, string idComuna, string idBarrio, string observacionesDireccion, string idCicloVital,
                                                string semanasGestacion, string asisteCPNoCXNoVI, string idEsquemaVacunacion, string idMadreAdolescente,
                                                string idTipoAfiliacion, string idEAPB, string idParentescoRedApoyo, string nombreCompletoRedApoyo,
                                                string celularRedApoyo, string idUsuarioCreacion)
        {
            try
            {
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@FechaRegistroCaracterizacion", Valor = fechaRegistroCaracterizacion, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdCuentame", Valor = idCuentame, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoIdentificacion", Valor = idTipoIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NombreFamiResponsable", Valor = (string.IsNullOrEmpty(nombreFamiResponsable) ? null : nombreFamiResponsable), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PrimerNombre", Valor = primerNombre, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SegundoNombre", Valor = (string.IsNullOrEmpty(segundoNombre) ? null : segundoNombre), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PrimerApellido", Valor = primerApellido, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SegundoApellido", Valor = (string.IsNullOrEmpty(segundoApellido) ? null : segundoApellido), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaNacimiento", Valor = fechaNacimiento, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdSexo", Valor = idSexo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdNacionalidad", Valor = idNacionalidad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Telefono", Valor = (string.IsNullOrEmpty(telefono) ? null : telefono), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Celular", Valor = celular, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Direccion", Valor = direccion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdComuna", Valor = idComuna, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdBarrio", Valor = idBarrio, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@ObservacionesDireccion", Valor = (string.IsNullOrEmpty(observacionesDireccion) ? null : observacionesDireccion), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCicloVital", Valor = idCicloVital, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SemanasGestacion", Valor = (string.IsNullOrEmpty(semanasGestacion) ? null : semanasGestacion), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AsisteCPNoCXNoVI", Valor = asisteCPNoCXNoVI, Tipo = typeof(byte) },
                    new Parametro { NombreParametro = "@IdEsquemaVacunacion", Valor = idEsquemaVacunacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMadreAdolescente", Valor = (string.IsNullOrEmpty(idMadreAdolescente) ? null : idMadreAdolescente), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoAfiliacion", Valor = idTipoAfiliacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdEAPB", Valor = idEAPB, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdParentescoRedApoyo", Valor = idParentescoRedApoyo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NombreCompletoRedApoyo", Valor = nombreCompletoRedApoyo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@CelularRedApoyo", Valor = celularRedApoyo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMatricula", Valor = null, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = null, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = null, Tipo = typeof(string) },
                };

                objBd.ejecutarProcedimiento("dbop_AddTBL_CARACTERIZACION", parametros);

                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool ActualizarCaracterizacion(DateTime fechaRegistroCaracterizacion, string idCuentame, string idTipoIdentificacion, string numeroIdentificacion,
                                                string nombreFamiResponsable, string primerNombre, string segundoNombre, string primerApellido, string segundoApellido,
                                                DateTime fechaNacimiento, string idSexo, string idNacionalidad, string telefono, string celular,
                                                string direccion, string idComuna, string idBarrio, string observacionesDireccion, string idCicloVital,
                                                string semanasGestacion, string asisteCPNoCXNoVI, string idEsquemaVacunacion, string idMadreAdolescente,
                                                string idTipoAfiliacion, string idEAPB, string idParentescoRedApoyo, string nombreCompletoRedApoyo,
                                                string celularRedApoyo, string idUsuarioCreacion)
        {
            try
            {
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@FechaRegistroCaracterizacion", Valor = fechaRegistroCaracterizacion, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdCuentame", Valor = idCuentame, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoIdentificacion", Valor = idTipoIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NombreFamiResponsable", Valor = (string.IsNullOrEmpty(nombreFamiResponsable) ? null : nombreFamiResponsable), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PrimerNombre", Valor = primerNombre, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SegundoNombre", Valor = segundoNombre, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PrimerApellido", Valor = primerApellido, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SegundoApellido", Valor = segundoApellido, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaNacimiento", Valor = fechaNacimiento, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdSexo", Valor = idSexo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdNacionalidad", Valor = idNacionalidad, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Telefono", Valor = telefono, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Celular", Valor = celular, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Direccion", Valor = direccion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdComuna", Valor = idComuna, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdBarrio", Valor = idBarrio, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@ObservacionesDireccion", Valor = observacionesDireccion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCicloVital", Valor = idCicloVital, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SemanasGestacion", Valor = semanasGestacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AsisteCPNoCXNoVI", Valor = asisteCPNoCXNoVI, Tipo = typeof(byte) },
                    new Parametro { NombreParametro = "@IdEsquemaVacunacion", Valor = idEsquemaVacunacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMadreAdolescente", Valor = (string.IsNullOrEmpty(idMadreAdolescente) ? null : idMadreAdolescente), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoAfiliacion", Valor = idTipoAfiliacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdEAPB", Valor = idEAPB, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdParentescoRedApoyo", Valor = idParentescoRedApoyo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NombreCompletoRedApoyo", Valor = nombreCompletoRedApoyo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@CelularRedApoyo", Valor = celularRedApoyo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_CARACTERIZACION", parametros);

                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ObtenerCaracterizacion(string numeroIdentificacion)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_CARACTERIZACION", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerMadresLactantes()
        {
            try
            {
                DataTable dtDatos;

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_MADRES", null).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public string InsertarMatricula(string numeroIdentificacion, DateTime fecha, string idTipoAccion, string idMotivoRetiro, string idCoordinador,
            string idSede, string idUba, string idCicloVital, string numeroIdentificacionMadre, string usuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Fecha", Valor = fecha, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdTipoAccion", Valor = idTipoAccion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMotivoRetiro", Valor = (string.IsNullOrEmpty(idMotivoRetiro)) ? null : idMotivoRetiro, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdSede", Valor = idSede, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUba", Valor = idUba, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCicloVital", Valor = idCicloVital, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NumeroIdentificacionMadre", Valor = (string.IsNullOrEmpty(numeroIdentificacionMadre) ? null: numeroIdentificacionMadre), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = usuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) }
                };

                resp = objBd.ejecutarProcedimiento("dbop_AddTBL_MATRICULA", parametros, "IdMatricula", DbType.String, 10);

                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return "";
            }
        }

        public DataTable ObtenerParticipantesCoordinador(string idCoordinador)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_CARACTERIZACIONCOORDINADOR", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ActualizarDocumentoIdentidad(string idDocumento, string idTipoIdentificacion, string numeroIdentificacion, string idUsuarioCreacion)
        {
            try
            {
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdDocumento", Valor = idDocumento, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdTipoIdentificacion", Valor = idTipoIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                objBd.ejecutarProcedimiento("dbop_CambioDocumentoIdentidad", parametros);

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
