<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarEntregaPaquete.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.EditarEntregaPaquete" %>

<form id="EditarEntregaPaquete">
    <div class="row">
        <div id="dvIdEntregaPaquete" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Id Entrega Paquete*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtIdEntregaPaquete" disabled="disabled" />
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
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
                <div class="col-sm-2">
                    <label class="control-label">Coordinador*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control select2" aria-label="Default select" id="ddlCoordinador" data-validation="required">
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Uba*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control select2" aria-label="Default select" id="ddlUbas" data-validation="required">
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Planilla de entrega del paquete*</label>
                </div>
                <div class="col-sm-4">
                    <input class="filestyle" type="file" id="flArchivo" data-buttontext="" data-buttonname="btn-cincopasitos" accept="application/pdf" data-validation="required">
                    <input id="btnCargar" type="button" class="btn btn-cargarAchivo" value="Cargar" style="display: none"/>&nbsp&nbsp
                    <a href="#" id="aArchivo" style="display: none"></a>
                    <input type="hidden" id="hidNombreArchivoGuid" />
                </div>
            </div>
        </div>
        
        <div id="dvAgregar" class="row" style="padding: 4px 4px 4px 4px; display: none">
            <div class="col-sm-12" style="text-align: right; margin: 0px 0px 0px -12px;">
                <input id="btnAgregar" type="button" class="btn btn-cincopasitos" value="Agregar" />
            </div>
        </div>

        <div id="dvGridAgregar" class="row" style="padding: 4px 4px 4px 4px; display: none">
            <div class="col-sm-12">
                <div class="box-body">
                    <table id="grdParticipantes" class="table table-bordered table-striped">
                    </table>
                </div>
            </div>
        </div>
    </div>
</form>
