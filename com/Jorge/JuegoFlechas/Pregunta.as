package Jorge.JuegoFlechas {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import Jorge.Utiles.*;
	import flash.display.Sprite;
	import gs.TweenLite;
	import gs.easing.*;
	import flash.events.MouseEvent;
	import fl.transitions.Fade;
	
	
	public class Pregunta extends MovieClip {
		public var resultado:Boolean = false;
		private var datos:XML;
		public var id:String;
		public var respuestaSel:Respuesta = null;
		public var flecha:Flecha;
		public var ref:Fase;
		
		public function Pregunta(_datos:XML, _ref:Fase) {
			onInicio(_datos,_ref);
		}
		
		private function onInicio(_datos:XML, _ref:Fase):void{
			stop();
			this.mouseChildren = false;
			
			datos = _datos;
			ref = _ref;
			id = datos.@id;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onDibuja);
			
		}
		
		private function onDibuja(evento:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, onDibuja);
			
			texto.htmlText = datos.toString();
			
			flecha = new Flecha(this);
			flecha.x = this.width;
			flecha.y = this.height/2;
			addChild(flecha);
			
			onListeners();
		}
		
		public function controlRespuesta(quien:Respuesta):void{
			/*if(respuestaSel != null){
				respuestaSel.activa();
			}
			this.respuestaSel = quien;
			resultado = quien.id == correcto;*/
		}
		
		private function onListeners():void{
			this.addEventListener(MouseEvent.MOUSE_OVER, _over);
			this.addEventListener(MouseEvent.MOUSE_OUT, _out);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, flecha._down);
		}
		
		private function _over(evento:MouseEvent):void{
			gotoAndStop(2);
		}
		
		private function _out(evento:MouseEvent):void{
			gotoAndStop(1);
		}
		
		public function destroy():void{
			this.removeEventListener(MouseEvent.MOUSE_OVER, _over);
			this.removeEventListener(MouseEvent.MOUSE_OUT, _out);
		}
	}
	
}
