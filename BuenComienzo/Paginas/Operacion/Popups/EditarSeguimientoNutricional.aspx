<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarSeguimientoNutricional.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.EditarSeguimientoNutricional" %>

<form id="EditarSeguimientoNutricional">
    <div class="row">
        <div id="dvIdSeguimientoNutricional" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Id seguimiento nutricional*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtIdSeguimientoNutricional" disabled="disabled" />
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
                    <label class="control-label">Fecha*</label>
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
                    <label class="control-label">Tipo de atención*</label>
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
                    <label class="control-label">Perimetro branquial</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtPerimetroBraquial" maxlength="6" />
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Desviación estandar P/T*</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtDesviacionEstandar" maxlength="4" data-validation="required"/>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">IMC*</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='text' class="form-control" id="txtIMC" maxlength="5" data-validation="required"/>
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
                    <label class="control-label">DX Asociado a enfermedad de base?*</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='checkbox' id="chkDXAsociadoEnfermedadBase" class='flat-red' style='opacity: 0;'>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Enfermedades*</label>
                </div>
                <div class="col-sm-4 group">
                    <textarea id="txtEnfermedades" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="1500" disabled></textarea>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Signos Físicos Carenciales*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtSignosFisicosCarenciales" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Inseguridad alimentaria*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlInseguridadAlimentaria" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Acceso a servicios públicos*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlAccesoServiciosPublicos" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Acceso a servicios de salúd*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlAccesoServiciosSalud" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Condiciones de la vivienda*</label>
                </div>
                <div class="col-sm-4 group">
                    <textarea id="txtCondicionesVivienda" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="1500"></textarea>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Aspectos psicosociales y/o vulneración de derechos*</label>
                </div>
                <div class="col-sm-4 group">
                    <textarea id="txtAspectosPsicosocialesVulneracionDerechos" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Lactancia Materna*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlLactancia" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Acciones realizadas en el seguimiento nutricional*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtAccionesRealizadas" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>
    </div>
</form>
