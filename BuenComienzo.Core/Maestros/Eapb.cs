using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Maestros
{
    public class Eapb
    {
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable ConsultarEapb()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("SELECT * from TBL_EAPB  ORDER BY NombreEapb ASC").Tables[0];
            return dtDatos;
        }

        public DataTable ConsultarEapbFacturables()
        {
            DataTable dtDatos;

            dtDatos = objBd.ejecutarSentenciaDS("select * from TBL_EAPB where Facturable = 1 ORDER BY NombreEapb ASC").Tables[0];
            return dtDatos;
        }

        public DataTable ConsultarEapbByRegimen(string idMaeTipoSeguridadSocial)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@idMaeTipoSeguridadSocial", Valor = idMaeTipoSeguridadSocial, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_Eapb_By_Regimen", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return null;
            }
        }

        public DataTable ConsultarEapbByRegimenFacturable(string idMaeTipoSeguridadSocial)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@idMaeTipoSeguridadSocial", Valor = idMaeTipoSeguridadSocial, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_Eapb_By_Regimen_Facturable", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return null;
            }
        }
    }    
}
