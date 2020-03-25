package Jorge.Test {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class Respuesta extends MovieClip {
		private var datos:XML;
		public var id:String;
		private var ref:Pregunta;
		
		public function Respuesta(_datos:XML, _ref:Pregunta) {
			onInicio(_datos, _ref);
		}
		
		private function onInicio(_datos:XML, _ref:Pregunta):void{
			stop();
			
			datos = _datos;
			ref = _ref;
			id = datos.@idR;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onDibuja);
		}
		
		private function onDibuja(evento:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, onDibuja);
			
			texto.htmlText = datos.toString();
			
			onListeners();
		}
		
		private function onListeners():void{
			activa();
			
			this.addEventListener(MouseEvent.CLICK, _click);
		}
		
		private function _over(evento:MouseEvent):void{
			gotoAndStop(2);
		}
		
		private function _out(evento:MouseEvent):void{
			gotoAndStop(1);
		}
		
		private function _click(evento:MouseEvent):void{
			gotoAndStop(3);
			desactiva();
			ref.controlRespuesta(this);
		}
		
		public function activa():void{
			this.addEventListener(MouseEvent.MOUSE_OVER, _over);
			this.addEventListener(MouseEvent.MOUSE_OUT, _out);
			_out(new MouseEvent("forzado"));
		}
		
		public function desactiva():void{
			this.removeEventListener(MouseEvent.MOUSE_OVER, _over);
			this.removeEventListener(MouseEvent.MOUSE_OUT, _out);
		}
		
		public function destroy():void{
			try{
				this.removeEventListener(MouseEvent.MOUSE_OVER, _over);
				this.removeEventListener(MouseEvent.MOUSE_OUT, _out);
			}catch(e:Error){
				
			}
		}
	}
	
}






