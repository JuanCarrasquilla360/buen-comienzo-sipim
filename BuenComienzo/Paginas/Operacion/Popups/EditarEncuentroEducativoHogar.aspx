<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarEncuentroEducativoHogar.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.EditarEncuentroEducativoHogar" %>

<form id="EditarEncuentroEducativoHogar">
    <div class="row">
        <div id="dvIdEncuentroEducativoHogar" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Id Encuentro Educativo en el Hogar*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtIdEncuentroEducativoHogar" disabled="disabled" />
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Participante*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control select2" aria-label="Default select" id="ddlParticipante" data-validation="required">
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Fecha*</label>
                </div>
                <div class="col-sm-4">
                    <div class='input-group' id='fechaEEH'>
                        <input type='text' class="form-control" id="txtfechaEEH" readonly="readonly" style="background-color: white" />
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
                    <label class="control-label">Tipo de EEH*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlTipoEEH" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <%--<div class="col-sm-2">
                    <label class="control-label">Sede de atención*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlSedes" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>--%>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Número EEH*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtNumeroEEH" disabled="disabled" />
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Motivo de EEH*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlMotivoEEH" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">EEH Efectivo?*</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='checkbox' id="chkEEHEfectivo" class='flat-red' style='opacity: 0;' runat="server" checked="checked">
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Motivo No Efectivo*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlMotivoNoEfectivo" data-validation="required" disabled="disabled">
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Observaciones*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtObservaciones" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>
    </div>
</form>
