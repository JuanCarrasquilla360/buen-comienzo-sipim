<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParticipanteEncuentroEducativo.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.ParticipanteEncuentroEducativo" %>

<form id="ParticipanteEncuentroEducativo">
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
                    <select class="form-control" aria-label="Default select" id="ddlCicloVital" disabled="disabled">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Asistencia*</label>
                </div>
                <div class="col-sm-4">
                    <input type='checkbox' id="chkAsistencia" class='flat-red' style='opacity: 0;' checked="checked" />
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Motivo inasistencia*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlMotivoInasistencia" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2" style="padding: 8px 15px 8px 15px;">
                    <label class="control-label">Tiene excusa?*</label>
                </div>
                <div class="col-sm-4" style="padding: 8px 15px 8px 15px;">
                    <input type='checkbox' id="chkTieneExcusa" class='flat-red' style='opacity: 0;'>
                </div>
                <div class="col-sm-2" style="padding: 8px 15px 8px 15px;">
                    <label class="control-label">Peso</label>
                </div>
                <div class="col-sm-4" style="padding: 8px 15px 8px 15px;">
                    <input type='text' class="form-control" id="txtPeso" maxlength="6" />
                </div>
                <div class="col-sm-2" style="padding: 8px 15px 8px 15px;">
                    <label class="control-label">Talla</label>
                </div>
                <div class="col-sm-4" style="padding: 8px 15px 8px 15px;">
                    <input type='text' class="form-control" id="txtTalla" maxlength="6" />
                </div>
                <div class="col-sm-2" style="padding: 8px 15px 8px 15px;">
                    <label class="control-label">DX Nutricional</label>
                </div>
                <div class="col-sm-4" style="padding: 8px 15px 8px 15px;">
                    <select class="form-control" aria-label="Default select" id="ddlDXNutricional">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2" style="padding: 8px 15px 8px 15px;">
                    <label class="control-label">Lactancia</label>
                </div>
                <div class="col-sm-4" style="padding: 8px 15px 8px 15px;">
                    <select class="form-control" aria-label="Default select" id="ddlLactancia" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-4" style="padding: 8px 15px 8px 15px;">
                    <label class="control-label">¿hasta que mes tuvo lactancia exclusiva?</label>
                </div>
                <div class="col-sm-2" style="padding: 8px 15px 8px 15px;">
                    <select class="form-control" aria-label="Default select" id="ddlMesLactanciaExclusiva" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>

                 <div class="col-sm-3" style="padding: 8px 15px 8px 15px;">
                    <label class="control-label"> ¿Porqué dejaron de darle leche materna?</label>
                </div>
                <div class="col-sm-3" style="padding: 8px 15px 8px 15px;">
                    <select class="form-control" aria-label="Default select" id="ddlPorqueSinLactancia" data-validation="required" disabled="disabled">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>

                <div class="col-sm-2" style="padding: 8px 15px 8px 15px;">
                    <label class="control-label">Perimetro branquial</label>
                </div>
                <div class="col-sm-4" style="padding: 8px 15px 8px 15px;">
                    <input type='text' class="form-control" id="txtPerimetroBraquial" maxlength="6" />
                </div>
                <div class="col-sm-2" style="padding: 8px 15px 8px 15px;">
                    <label class="control-label">Perimetro cefálico</label>
                </div>
                <div class="col-sm-4" style="padding: 8px 15px 8px 15px;">
                    <input type='text' class="form-control" id="txtPerimetroCefalico" maxlength="6" />
                </div>
                <div class="col-sm-2" style="padding: 8px 15px 8px 15px;">
                    <label class="control-label">Observaciones</label>
                </div>
                <div class="col-sm-4" style="padding: 8px 15px 8px 15px;">
                    <textarea id="txtObservaciones" cols="40" rows="2" class="form-control" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>
    </div>
</form>
