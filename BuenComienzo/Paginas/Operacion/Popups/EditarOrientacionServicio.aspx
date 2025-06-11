<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarOrientacionServicio.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.EditarOrientacionServicio" %>

<form id="EditarOrientacionServicio">
    <div class="row">
        <div id="dvIdOrientacionServicio" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Id Orientación a Servicio*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtIdOrientacionServicio" disabled="disabled" />
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
                    <label class="control-label">Fecha Orientación a Servicio*</label>
                </div>
                <div class="col-sm-4">
                    <div class='input-group' id='fechaOS'>
                        <input type='text' class="form-control" id="txtfechaOS" readonly="readonly" style="background-color: white" />
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
                    <label class="control-label">Número identificación del Cuidador*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtNumeroIdentificacionCuidador" maxlength="15" data-validation="required" />
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Nombre del Cuidador*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtNombreCuidador" maxlength="100" data-validation="required" />
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Celular del Cuidador*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtCelularCuidador" maxlength="10" data-validation="required" />
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Tipo de Orientación a Servicio*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlTipoOS" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Lugar al que remite*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtLugarRemite" maxlength="100" data-validation="required" />
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

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Formato Orientación a Servicio*</label>
                </div>
                <div class="col-sm-4">
                    <input class="filestyle" type="file" id="flArchivo" data-buttontext="" data-buttonname="btn-cincopasitos" accept="application/pdf" data-validation="required">
                    <input id="btnCargar" type="button" class="btn btn-cargarAchivo" value="Cargar" style="display: none" />&nbsp&nbsp
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


        <div id="ocuFechaPrimerSeguimiento" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Fecha Primer Seguimiento*</label>
                </div>
                <div class="col-sm-4">
                    <div class='input-group' id='fechaPrimerSeguimiento'>
                        <input type='text' class="form-control" id="txtfechaPrimerSeguimiento" readonly="readonly" style="background-color: white" />
                        <div class="input-group-addon">
                            <div class="input-group-text" style="cursor: pointer">
                                <span class="far fa-calendar-alt fa-lg"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div id="observacionesPrimerSeguimiento" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Observaciones del primer seguimiento*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtObservacionPrimerSeguimiento" cols="40" rows="2" class="form-control" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div id="ocuFechaSegundoSeguimiento" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Fecha Segundo Seguimiento*</label>
                </div>
                <div class="col-sm-4">
                    <div class='input-group' id='fechaSegundoSeguimiento'>
                        <input type='text' class="form-control" id="txtfechaSegundoSeguimiento" readonly="readonly" style="background-color: white" />
                        <div class="input-group-addon">
                            <div class="input-group-text" style="cursor: pointer">
                                <span class="far fa-calendar-alt fa-lg"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="observacionesSegundoSeguimiento" class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Observaciones del segundo seguimiento*</label>
                </div>
                <div class="col-sm-10">
                    <textarea id="txtObservacionSegundoSeguimiento" cols="40" rows="2" class="form-control" style="resize: none" maxlength="500"></textarea>
                </div>
            </div>
        </div>

        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">                
                <div class="col-sm-2">
                    <label class="control-label">La orientación fue cerrada?</label>
                </div>
                <div class="col-sm-4 group">
                    <input type='checkbox' id="chkOrientacionCerrada" class='flat-red' style='opacity: 0;' runat="server">
                </div>
            </div>
        </div>

        <%--<div id="dvGridAgregar" class="row" style="padding: 4px 4px 4px 4px; display: none">
            <div class="col-sm-12">
                <div class="box-body">
                    <table id="grdParticipantes" class="table table-bordered table-striped">
                    </table>
                </div>
            </div>
        </div>--%>
    </div>
</form>
