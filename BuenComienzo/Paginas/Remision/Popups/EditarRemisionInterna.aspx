<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarRemisionInterna.aspx.cs" Inherits="BuenComienzo.Paginas.Remision.Popups.EditarRemisionInterna" %>

<form id="EditarRemisionInterna">
    <div class="row">
        <div id="dvIdRemisionInterna" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Id Remisión Interna*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtIdRemisionInterna" disabled="disabled" />
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
                    <label class="control-label">Motivo de la Remisión*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlMotivoRemisionInterna" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Profesional al que se remite la remisión*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlProfesionalRemision" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
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
                    <textarea id="txtObservacion" cols="40" rows="2" class="form-control" data-validation="required" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>
    </div>
</form>
