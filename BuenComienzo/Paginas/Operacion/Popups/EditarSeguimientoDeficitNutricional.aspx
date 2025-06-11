<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarSeguimientoDeficitNutricional.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.EditarSeguimientoDeficitNutricional" %>

<form id="EditarSeguimientoDeficitNutricional">
    <div class="row">
        <div id="dvIdSeguimientoDeficitNutricional" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Id seguimiento Déficit nutricional*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtIdSeguimientoDeficitNutricional" disabled="disabled" />
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Participante*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlParticipante" data-validation="required">
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Fecha de seguimiento*</label>
                </div>
                <div class="col-sm-4">
                    <div class='input-group' id='fecha'>
                        <input type='text' class="form-control" id="txtfecha" readonly="readonly" style="background-color: white" />
                        <div class="input-group-addon">
                            <div class="input-group-text" style="cursor: pointer">
                                <span class="far fa-calendar-alt fa-lg"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Medio por el cual se realizó el seguimiento*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlTipoAtencion" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Ciclo vital*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlCicloVital" disabled="disabled">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Peso</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtPeso" maxlength="6" />
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Talla</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtTalla" maxlength="6" />
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Perímetro branquial</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtPerimetroBraquial" maxlength="6" disabled="disabled" />
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Perímetro cefálico</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtPerimetroCefalico" maxlength="4" disabled="disabled" />
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Semanas de Gestación</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtSemanasGestacion" maxlength="2" disabled="disabled" />
                </div>
                <div class="col-sm-2">
                    <label class="control-label">DX nutricional*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlDXNutricional" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>


        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Talla/Edad</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlTallaEdad" disabled="disabled">
                        <option value="Talla baja para la edad o retraso en talla" selected>Talla baja para la edad o retraso en talla</option>
                        <option value="Riesgo de talla baja para la edad" selected>Riesgo de talla baja para la edad</option>
                        <option value="Talla adecuada para la edad" selected>Talla adecuada para la edad</option>
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Cuántos seguimientos se han realizado?</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlCuantosSeguimientosRealizado" data-validation="required">
                        <option value="0" selected>0</option>
                        <option value="1" selected>1</option>
                        <option value="2" selected>2</option>
                        <option value="3" selected>3</option>
                        <option value="4" selected>4</option>
                        <option value="5" selected>5</option>
                        <option value="6" selected>6</option>
                        <option value="7" selected>7</option>
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Se entregó remisión física?*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlRemisionFisica" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">La remisión fue efectiva para la atención en salud?*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlRemisionEfectivaAtencionSalud" data-validation="required" disabled="disabled">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Si fué atendido por Salud, describa las atenciones que ha recibido</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtDescribaAtencionesRecibidas" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500" disabled="disabled"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Si no ha sido atendido por Salud, ¿Se notificó al consejero nutricional del proyecto nutrir para sanar, sanar para crecer?</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlNotificaNutrirParaSanar" data-validation="required" disabled="disabled">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Teniendo en cuenta la anterior respuesta, mencione las acciones implementadas</label>
                </div>
                <div class="col-sm-4 group">
                    <textarea id="txtAccionesImplementadas" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500" disabled="disabled"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Hubo hospitalización?*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlHuboHospitalizacion" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Recibe complementación por la entidad de salud?*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlRecibeComplementacionEntidadSalud" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Qué Complementación recibe?*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlQueComplementacionRecibe" data-validation="required" disabled="disabled">
                        <option value="FTLC PLUMPYNUT" selected>FTLC PLUMPYNUT</option>
                        <option value="Otra" selected>Otra</option>
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Cuál otra complementación?</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtCualOtraComplementacion" maxlength="50" data-validation="required" disabled="disabled" />
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Se realizó diligenciamiento de datos en el módulo administrativo para el reporte de participantes con desnutrición aguda moderada o severa al sivigila*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlDiligenciamientoSivigila" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">¿El participante recibe ración alimentaria por parte del proyecto buen comienzo 365?*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlRecibeRacionAlimentaria365" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">¿El participante recibe ración alimentaria por parte del programa nutrir para sanar, sanar para crecer?*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlRecibeRacionNutrirParaSanar" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Si recibe Nutrir para sanar, ¿Qué tipo de ración alimentaria recibe?</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlQueTipoRacionNutrirParaSanarRecibe" data-validation="required" disabled="disabled">
                        <option value="A" selected>A</option>
                        <option value="B1" selected>B1</option>
                        <option value="B2" selected>B2</option>
                        <option value="C" selected>C</option>
                        <option value="D" selected>D</option>
                        <option value="F" selected>F</option>
                        <option value="Micronutrientes" selected>Micronutrientes</option>
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Clasificación de la ELCSA aplicada*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlClasificacionELCSA" data-validation="required">
                        <option value="Seguridad alimentaria" selected>Seguridad alimentaria</option>
                        <option value="Inseguridad alimentaria leve" selected>Inseguridad alimentaria leve</option>
                        <option value="Inseguridad alimentaria moderada" selected>Inseguridad alimentaria moderada</option>
                        <option value="Inseguridad alimentaria severa" selected>Inseguridad alimentaria severa</option>
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Cambió su estado nutricional?*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlCambioSuEstadoNutricional" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Cuál es su nuevo diagnóstico?*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlNuevoDiagnostico" data-validation="required" disabled="disabled">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Aspectos alimentarios (consumo de alimentos, rechazos, intolerancias, cultura alimentaria, entre otros)*</label>
                </div>
                <div class="col-sm-4 group">
                    <textarea id="txtAspectosAlimentarios" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Aspectos bioquímicos*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtAspectosBioquimicos" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Aspectos clínicos*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtAspectosClinicos" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Aspectos económicos*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtAspectosEconomicos" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Aspectos familiares*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtAspectosFamiliares" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Aspectos psicosociales*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtAspectosPsicosociales" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Devolución a las familias de aspectos abordados sobre el estado nutricional del participante*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtDevolucionFamiliaAspectosAbordadosNutricional" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">¿Se realizó socialización del seguimiento con equipo interdisciplinario?*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlSocializacionSeguimientoEquipo" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Activación de rutas por presunta vulneración de derechos o inobservancia*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlActivacionRutaVulneracionDerechos" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Si la respuesta anterior es si, específicar cuál*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtEspecificarCualVulneracion" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500" disabled="disabled"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Describa las acciones realizadas*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtDescribaAccionesRealizadas" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Observaciones Generales*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtObservacionesGenerales" cols="40" rows="2" class="form-control" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Compromisos establecidos con la familia*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtCompromisoEstablecidoConFamilia" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Soporte con la atención en salud, remisión entregada a la familia y evidencia registro de información en SIBC*</label>
                </div>
                <div class="col-sm-4">
                    <input class="filestyle" type="file" id="flArchivo" data-buttontext="" data-buttonname="btn-cincopasitos" accept="application/pdf" data-validation="required">
                    <input id="btnCargar" type="button" class="btn btn-cargarAchivo" value="Cargar" style="display: none" />&nbsp&nbsp
                    <a href="#" id="aArchivo" style="display: none"></a>
                    <input type="hidden" id="hidNombreArchivoGuid" />
                </div>
                <div class="col-sm-2">
                    <label class="control-label">El caso fue cerrado?</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='checkbox' id="chkCasoCerrado" class='flat-red' style='opacity: 0;' runat="server">
                </div>
            </div>
        </div>               

    </div>
</form>
