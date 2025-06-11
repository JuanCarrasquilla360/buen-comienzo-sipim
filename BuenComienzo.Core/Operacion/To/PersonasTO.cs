using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuenComienzo.Core.Operacion.To
{
    public class PersonasTO
    {
        public int IdPersona { get; set; }
        public string IdDocumento { get; set; }
        public int IdMaeTipoDocumento { get; set; }
        public string PrimerNombre { get; set; }
        public string SegundoNombre { get; set; }
        public string PrimerApellido { get; set; }
        public string SegundoApellido { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string Sexo { get; set; }
        public string OrientacionSexual { get; set; }
        public string Direccion { get; set; }
        public string DireccionObservaciones { get; set; }
        public string Zona { get; set; }
        public int IdComuna { get; set; }
        public string IdBarrio { get; set; }
        public string Telefono { get; set; }
        public string Celular { get; set; }
        public string FichaSisben { get; set; }
        public string PuntajeSisben { get; set; }
        public int IdMaeTipoSeguridadSocial { get; set; }
        public string IdMaeEAPB { get; set; }
        public string TipoAfiliado { get; set; }
        public int IdMaeNivelEducativo { get; set; }
        public int IdMaeOcupacion { get; set; }
        public int IdMaeGrupoEtnia { get; set; }
        public string IdUsuarioCreacion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string IdUsuarioModificacion { get; set; }
        public DateTime FechaModificacion { get; set; }
        public int IdMaeTipoParentesco { get; set; }
        public string IdMaePais { get; set; }
        public string SeEncuentraEscolarizado { get; set; }
        public int IdMaeTipoContrato { get; set; }
        public int IdMaeIngresosMensualesPromedio { get; set; }
        public string SeEncuentraSisbenizado { get; set; }
        public string IdMaeMunicipioSisbenizado { get; set; }
        public string IdMaeMunicipioAfiliado { get; set; }
        public string TieneCarnetVacunas { get; set; }
        public string SeEncuentraEmbarazada { get; set; }
		public string PorqueMedioSeDioCuentaEmbarazo { get; set; }
		public int NumeroSemanasGestacion { get; set; }
		public string SeHaVacunadoDuranteEmbarazo { get; set; }
		public string ElEmbarazoFuePlaneado { get; set; }
		public int QueNumeroDeEmbarazoEs { get; set; }
		public string AsisteAControlPrenatal { get; set; }
		public string FechaUltimoControl { get; set; }
        public int IdMaeDiscapacidad { get; set; }
        public string TieneRegistroPersonasConDiscapacidad { get; set; }
        public string SeConsideraVictimaConflictoArmado { get; set; }
        public string PresentaAlgunaEnfermedadCronica { get; set; }
        public string CorreoElectronico { get; set; }
        public string Instagram { get; set; }
        public string Facebook { get; set; }
        public int IdMaeProgramaAtencionEspecial { get; set; }
        public int IdMaeFactorProtectorConsidera { get; set; }
        public int IdMaeFactorProtectorObservaProfesional { get; set; }
        public string IdMaeEstadoCivil { get; set; }
        public string MetodoPlanificacionActual { get; set; }
        public string PresentaTos { get; set; }
        public string PresentaOdinofagia { get; set; }
        public string PresentaFiebre { get; set; }
        public string PresentaMalestarGeneral { get; set; }
        public string PresentaDificulaParaRespirar { get; set; }
        public string ReportoEAPB { get; set; }
        public decimal Puntaje { get; set; }


    }
}
