using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;

namespace BuenComienzo.Core.Maestros
{
    public class ActividadesVisita
    {

        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public DataTable ConsultarActividadesVisita(string idPerfil)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>();
                parametros.Add(new Parametro { NombreParametro = "@IdPerfil", Valor = idPerfil, Tipo = typeof(string) });

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_ActividadesVisita_By_Perfil", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return null;
            }
        }

    }
}
