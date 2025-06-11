using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Administracion.To
{
    public class RespuestaTO
    {
        public bool resultado { get; set; }

        public string mensaje { get; set; }

        public string datos { get; set; }

        public string tipoMensaje { get; set; }
        public int code { get; set; }

        public enum ErrorCodeResponse
        {
            Session_Expired = -555,
            Session_OK = 555,
            QueryOK = 1,
            QueryError = -1,

        }
    }
}
