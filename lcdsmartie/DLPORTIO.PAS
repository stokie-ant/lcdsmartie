{******************************************************************************
 *
 *  LCD Smartie - LCD control software.
 *  Copyright (C) 2000-2003  BassieP
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 *  $Source: /root/lcdsmartie-cvsbackup/lcdsmartie/Attic/DLPORTIO.PAS,v $
 *  $Revision: 1.3 $ $Date: 2004/11/05 13:16:21 $
 *****************************************************************************}
unit DLPortIO;

interface

function DlPortReadPortUchar(poort: Word): Byte; stdcall; external 'dlportio.dll';

procedure DlPortWritePortUchar(poort: Word; Value: Byte); stdcall; external 'dlportio.dll';

implementation

end.
 
