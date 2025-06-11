<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarArchivo.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.AgregarArchivo" %>

<form id="frmAgregarArchivo" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <label class="control-label">Archivo</label>
        </div>
        <div class="col-sm-12">
            <input id="flArchivoAdjuntar" class="filestyle" type="file" runat="server" data-buttontext="" data-buttonname="btn-cincopasitos" />
        </div>
        <div class="col-sm-12">
            <p style="font-size: 12px; text-align: justify">Si el archivo es de tipo PDF y pesa mas de 2MB puede comprimirlo en la siguiente URL para que tenga un peso menor <a href="https://smallpdf.com/es/comprimir-pdf" target="_blank">https://smallpdf.com/es/comprimir-pdf</a></p>
        </div>
    </div>
</form>
