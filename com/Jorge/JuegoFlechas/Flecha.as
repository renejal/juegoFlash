package  Jorge.JuegoFlechas{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Jorge.Utiles.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Flecha extends Sprite{
		private var ref:Pregunta;
		
		public function Flecha(_ref:Pregunta) {
			onInicio(_ref);
		}
		
		private function onInicio(_ref:Pregunta):void{
			ref = _ref;
		}
		
		private function onDibuja():void{
			
			onListeners();
		}
		
		private function onListeners():void{
			
		}
		
		public function _down(evento:MouseEvent):void{
			Globales.__root.addEventListener(MouseEvent.MOUSE_MOVE, _move);
			Globales.__root.addEventListener(MouseEvent.MOUSE_UP, _up);
			
			Tools.ponAlFrente(ref);
		}
		
		private function _move(evento:MouseEvent):void{
			this.graphics.clear();
			this.graphics.lineStyle(2, 0xFFFFFF, 1);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(mouseX-1, mouseY-1);
		}
		
		private function _up(evento:MouseEvent):void{
			Globales.__root.removeEventListener(MouseEvent.MOUSE_MOVE, _move);
			Globales.__root.removeEventListener(MouseEvent.MOUSE_UP, _up);
			
			if(ref.respuestaSel != null){
				ref.respuestaSel.activa();
				ref.resultado = false;
			}
			
			var existe:Boolean = false;
			for(var i:uint =0; i<ref.ref.clipRespuestas.numChildren; i++){
				var respuesta:Respuesta = ref.ref.clipRespuestas.getChildAt(i) as Respuesta;
				if(respuesta.hitTestPoint(Globales.__root.mouseX, Globales.__root.mouseY)){
					var bounds:Rectangle = respuesta.getBounds(this);
					
					this.graphics.clear();
					this.graphics.lineStyle(2, 0xFFFFFF, 1);
					this.graphics.moveTo(0, 0);
					this.graphics.lineTo(bounds.x, bounds.y + bounds.height/2);
					
					respuesta.desactiva();
					if(respuesta.pregunta != null){
						respuesta.pregunta.flecha.reset();
					}
					respuesta.pregunta = ref;
					
					ref.respuestaSel = respuesta;
					trace(ref.id + " == " + respuesta.id);
					ref.resultado = ref.id == respuesta.id;
					
					existe = true;
					break;
				}
			}
			
			if(!existe){
				reset();
			}
		}
		
		public function reset():void{
			this.graphics.clear();
		}
	}
	
}
