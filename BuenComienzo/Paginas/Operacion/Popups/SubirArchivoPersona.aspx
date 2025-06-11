<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubirArchivoPersona.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.SubirArchivoPersona" %>

<form id="frmSubirArchivoPersona">
    <div class="row">
        <div class="panel panel-default" style="margin:5px">
            <div class="panel-body">
                <div class="row" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">                        
                        <div class="col-sm-2">
                            <label class="control-label">Nro. de documento</label>
                        </div>
                        <div class="col-sm-4">
                            <input type="text" id="txtIdDocumento" name="IdDocumento" runat="server" class="form-control" disabled>
                        </div>
                        <div class="col-sm-2">
                            <label class="control-label">Nombre</label>
                        </div>
                        <div class="col-sm-4">
                            <input type="text" id="txtPrimerNombre" name="PrimerNombre" runat="server" class="form-control" disabled>
                        </div>
                    </div>
                </div>
                <div class="row" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">
                        <div class="col-sm-2">
                            <label class="control-label">Archivo</label>
                        </div>
                        <div class="col-sm-4">
                            <input id="flArchivoAdjuntar" class="filestyle" type="file" runat="server" data-buttontext="" data-buttonname="btn-cincopasitos" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-default" style="margin:5px">
            <div class="panel-body">
               <div class="row" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">
                        <div class="col-sm-2">
                            <label class="control-label">Tipo de documento</label>
                        </div>
                        <div class="col-sm-4">
                            <select id="ddlTipoArchivoPersona" runat="server" class="form-control" data-validation="required">
                                <option value="">--Seleccione--</option>
                            </select>
                        </div>
                        <div class="col-sm-2">
                            <span class="glyphicon glyphicon-plus" id="addArchivo" style="cursor:pointer" aria-hidden="true"></span>
                            <%--<input type="button" id="btnSubirDocumento" class="btn btn-cincopasitos" value="Cargar documento">--%>
                        </div>
                        <div class="col-sm-4" style="font-size=10px;">
                            <span> Si el archivo es de tipo PDF puede comprimirlo en la siguiente URL para que tenga un peso menor <a href="https://smallpdf.com/es/comprimir-pdf" target="_blank">https://smallpdf.com/es/comprimir-pdf</a> </span>
                        </div>
                    </div>
                </div>

                <div id="dvDocumentos" style="padding: 4px 0px 4px 0px;">
                <table id="gvDocumentos" class="table table-bordered table-striped table-hover table-heading table-datatable" style="width: 100% !important">
                    <thead>
                        <tr>
                            <th id="thControles" style="width: 5% !important"></th>
                            <th style="text-align: center; width: 15% !important">Código del documento</th>
                            <th style="text-align: center; width: 20% !important">Tipo de documento</th>
                            <th style="text-align: center; width: 20% !important">Documento</th>
                            <th style="text-align: center; width: 20% !important">Usuario creación</th>
                            <th style="text-align: center; width: 20% !important">Fecha creación</th>
                        </tr>
                    </thead>
                </table>
        </div>
            </div>
        </div>
        
    </div>

</form>