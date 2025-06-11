<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarEncuentroEducativo.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.EditarEncuentroEducativo" %>

<form id="EditarEncuentroEducativo">
    <div class="row">
        <div id="dvIdEncuentroEducativo" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Id Encuentro Educativo*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtIdEncuentroEducativo" disabled="disabled" />
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Programación*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control select2" aria-label="Default select" id="ddlProgramacion" data-validation="required">
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Tema*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control select2" aria-label="Default select" id="ddlTema" data-validation="required">
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Planilla del encuentro*</label>
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
