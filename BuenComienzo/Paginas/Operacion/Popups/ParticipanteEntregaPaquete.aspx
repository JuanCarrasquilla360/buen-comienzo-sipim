<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParticipanteEntregaPaquete.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.ParticipanteEntregaPaquete" %>

<form id="ParticipanteEntregaPaquete">
    <div class="row">
        <div id="dvExtemporaneo" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-12">
                    <label class="control-label">Participante extemporáneo?</label>&nbsp&nbsp&nbsp<input type='checkbox' id="chkExtemporane" class='flat-red' style='opacity: 0;'>
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
                    <label class="control-label">Ciclo vital*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlCicloVital" data-validation="required" disabled="disabled">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Paquete?*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlPaquete" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Bienestarina*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlBienestarina" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Complemento?*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlComplemento" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</form>
