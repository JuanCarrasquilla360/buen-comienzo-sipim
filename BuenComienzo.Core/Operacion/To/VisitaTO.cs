using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Operacion.To
{
    public class VisitaTO
    {
        public int IdVisita { get; set; }
        public string IdCabezaHogar { get; set; }
        public string NombreCabezaHogar { get; set; }
        public string IdDocumento { get; set; }
        public int IdMaeTipoDocumento { get; set; }
        public string PrimerNombre { get; set; }
        public string SegundoNombre { get; set; }
        public string PrimerApellido { get; set; }
        public string SegundoApellido { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string Sexo { get; set; }
        public string Telefono { get; set; }
        public string Celular { get; set; }
        public DateTime FechaVisita { get; set; }
        public string Programa { get; set; }
        public int IdMaeActividadVisita { get; set; }
        public string Efectiva { get; set; }
        public string Enfermeria { get; set; }        
        public string Nutricion { get; set; }
        public string SaludBucal { get; set; }
        public string SaludAmbiental { get; set; }
        public string SaludMental { get; set; }
        public string Spa { get; set; }
        public string AreaSocial { get; set; }
        public string Observaciones { get; set; }
        public string IdUsuarioCreacion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string IdUsuarioModificacion { get; set; }
        public DateTime FechaModificacion { get; set; }

    }
}
