package Jorge.JuegoArrastrar {
	import flash.display.Sprite
	import Jorge.Utiles.*;
	import flash.geom.Rectangle;
	
	import gs.TweenLite;
	import gs.easing.*;
	
	public class Fase extends Sprite{
		private var datos:XML;
		private var preguntas:Array = new Array();
		private var respuestas:Array = new Array();
		public var clipPreguntas:Sprite = new Sprite();
		public var clipRespuestas:Sprite = new Sprite();
		public var enunciado:String;
		
		
		public function Fase(_datos:XML) {
			onInicio(_datos);
		}
		
		private function onInicio(_datos:XML):void{
			datos = _datos
			
			enunciado = datos.enunciado.toString();
			
			var _preguntas:XMLList = datos..pregunta;
			preguntas = new Array();
			for each (var item:XML in _preguntas){
				preguntas.push(item);
			}
			Tools.randomiza(preguntas);
			
			var _respuestas:XMLList = datos..respuesta;
			respuestas = new Array();
			for each (item in _respuestas){
				respuestas.push(item);
			}
			Tools.randomiza(respuestas);
			
			onDibuja();
		}
		
		private function onDibuja():void{
			var posX:Number = 0;
			for(var i:uint = 0; i<preguntas.length; i++){
				var pregunta:Pregunta = new Pregunta(preguntas[i], this);
				pregunta.x = posX;
				posX += pregunta.width + 15;
				clipPreguntas.addChild(pregunta);
			}
			
			posX = 0;
			for(i = 0; i<respuestas.length; i++){
				var respuesta:Respuesta = new Respuesta(respuestas[i], this);
				respuesta.x = posX;
				posX += respuesta.width + 15;
				
				respuesta.almacenaPosicion();
				clipRespuestas.addChild(respuesta);
			}
			
			clipPreguntas.y = 250;
			clipPreguntas.x = (950 - clipPreguntas.width) / 2;
			clipRespuestas.y =400;
			clipRespuestas.x = (950 - clipRespuestas.width) / 2;
			addChild(clipPreguntas);
			addChild(clipRespuestas);
			
			onListeners();
		}
		
		private function onListeners():void{
			
		}
		
		public function controlUp(quien:Respuesta):void{
			
			var existe:Boolean = false;
			for(var i:uint=0; i<this.clipPreguntas.numChildren; i++){
				var _pregunta:Pregunta = clipPreguntas.getChildAt(i) as Pregunta;
				if(_pregunta.hitTestObject(quien.clip)){
					quien.x = -clipRespuestas.x + clipPreguntas.x + _pregunta.x + _pregunta.caja.x;
					quien.y = -clipRespuestas.y + clipPreguntas.y + _pregunta.y + _pregunta.caja.y;
					
					_pregunta.resultado = _pregunta.id == quien.id
					
					if(_pregunta.respuesta != null && _pregunta.respuesta!= quien){
						_pregunta.respuesta.recoloca();
						_pregunta.respuesta.pregunta = null;
					}
					_pregunta.respuesta = quien;
					
					if(quien.pregunta != null){
						quien.pregunta.respuesta = null;
					}
					quien.pregunta = _pregunta;
					
					existe = true;
					break;
				}
			}
			if(!existe){
				TweenLite.to(quien, 0.2, {x:quien.posX0, y:quien.posY0, ease:Expo.easeOut});
				if(quien.pregunta != null){
					quien.pregunta.resultado = false;
				}
			}
		}
		
		public function destroy():void{
			
		}
	}
	
}
