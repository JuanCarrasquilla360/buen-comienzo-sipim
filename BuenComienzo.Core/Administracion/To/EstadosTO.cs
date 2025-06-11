using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Administracion.To
{
    public class EstadosTO
    {
        public int IdMaeEstado { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public bool Cierra { get; set; }
    }
}
