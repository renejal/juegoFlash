package Jorge.JuegoFlechas {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	import Jorge.Utiles.*;
	
	
	public class Fase extends MovieClip {
		private var datos:XML;
		public var id:String;
		private var preguntas:Array;
		private var respuestas:Array;
		public var clipPreguntas:Sprite = new Sprite();
		public var clipRespuestas:Sprite = new Sprite();
		
		public function Fase(_datos:XML) {
			onInicio(_datos);
		}
		
		private function onInicio(_datos:XML):void{
			datos = _datos;
			id = datos.@id;
			
			var _preguntas:XMLList = datos..pregunta;
			preguntas = new Array();
			for each(var item:XML in _preguntas){
				preguntas.push(item);
			}
			preguntas = Tools.randomiza(preguntas);
			
			var _respuestas:XMLList = datos..respuesta;
			respuestas = new Array();
			for each(item in _respuestas){
				respuestas.push(item);
			}
			respuestas = Tools.randomiza(respuestas);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onDibuja);
			
		}
		
		private function onDibuja(evento:Event):void{
			enunciado.htmlText = datos.enunciado.toString();
			
			var posY:Number = 0;
			for(var i:uint=0; i<preguntas.length; i++){
				var pregunta:Pregunta = new Pregunta(preguntas[i], this);
				pregunta.y = posY;
				posY += pregunta.height + 15;
				clipPreguntas.addChild(pregunta);
			}
			clipPreguntas.x = 50;
			clipPreguntas.y = (400 - clipPreguntas.height)/2;
			
			
			posY = 0;
			for(i=0; i<respuestas.length; i++){
				var respuesta:Respuesta = new Respuesta(respuestas[i]);
				respuesta.y = posY;
				posY += respuesta.height + 15;
				clipRespuestas.addChild(respuesta);
			}
			clipRespuestas.x = 280;
			clipRespuestas.y = (400 - clipRespuestas.height)/2;
			addChild(clipRespuestas);
			addChild(clipPreguntas);
			
			onListeners();
		}
		
		private function onListeners():void{
			
		}
		
		public function destroy():void{
			
		}
	}
	
}
