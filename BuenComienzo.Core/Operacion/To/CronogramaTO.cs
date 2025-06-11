using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Operacion.To
{
    public class CronogramaTO
    {
        public int IdCronograma { get; set; }
        public DateTime Fecha { get; set; }
        public string HoraInicio { get; set; }
        public string HoraFinal { get; set; }
        public string IdLugar { get; set; }
        public string IdComuna { get; set; }
        public string IdActividad { get; set; }
        public string Estado { get; set; }
        public string Observaciones { get; set; }
        public string IdUsuarioCreacion { get; set; }
        public DateTime? FechaCreacion { get; set; }
        public string IdUsuarioModificacion { get; set; }
        public DateTime? FechaModificacion { get; set; }
    }
}
