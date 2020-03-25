package Jorge.JuegoArrastrar {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import Jorge.Utiles.*;
	
	
	public class Pregunta extends MovieClip {
		private var datos:Object;
		private var seleccionado:Boolean = false;
		public var ref:Fase;
		public var id:String;
		public var resultado:Boolean = false;
		public var respuesta:Respuesta;
		
		public function Pregunta(_datos:Object, _ref:Fase) {
			onInicio(_datos, _ref);
		}
		
		private function onInicio(_datos:Object, _ref:Fase):void{
			stop();
			
			datos = _datos;
			ref = _ref;
			this.id = datos.@id;
			
			addEventListener(Event.ADDED_TO_STAGE, onDibuja);
		}
		
		private function onDibuja(evento:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, onDibuja);
			
			texto.text = datos.toString();
			
			onListeners();
		}
		
		private function onListeners():void{
			this.addEventListener(MouseEvent.MOUSE_OVER, _over);
			this.addEventListener(MouseEvent.MOUSE_OUT, _out);
			
		}
		
		private function _over(evento:MouseEvent):void{
			gotoAndStop(2);
		}
		
		private function _out(evento:MouseEvent):void{
			if(!seleccionado){
				gotoAndStop(1);
			}else{
				gotoAndStop(3);
			}
		}
		
		public function activa():void{
			gotoAndStop(3);
			seleccionado = true;
		}
		
		public function desactiva():void{
			gotoAndStop(1);
			seleccionado = false;
		}
		
		public function controlRespuesta(_respuesta:Respuesta):void{
			
		}
		
		
		public function destroy():void{
			this.removeEventListener(MouseEvent.MOUSE_OVER, _over);
			this.removeEventListener(MouseEvent.MOUSE_OUT, _out);
		}
	}
	
}





