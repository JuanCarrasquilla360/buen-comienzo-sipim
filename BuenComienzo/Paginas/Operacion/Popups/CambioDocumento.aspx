<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CambioDocumento.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.CambioDocumento" %>

<form id="CambioDocumento">
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
                            <label class="control-label">Tipo de identificación*</label>
                        </div>
                        <div class="col-sm-4 group">
                            <select class="form-control" aria-label="Default select" id="ddlTipoIdentificacion" data-validation="required">
                            </select>
                        </div>
                        <div class="col-sm-2">
                            <label class="control-label">Nuevo Número de identificación*</label>
                        </div>
                        <div class="col-sm-4">
                            <input type='text' class="form-control" id="txtNumeroIdentificacion" maxlength="15" data-validation="required" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
