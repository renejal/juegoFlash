package  {
	
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	
	import Jorge.Utiles.*;
	import gs.TweenLite;
	import gs.easing.*;
	import Jorge.JuegoFlechas.Fase;
	import fl.transitions.Fade;
	import Jorge.JuegoFlechas.Pregunta;
	
	
	public class Flechas extends MovieClip {
		private var loader:URLLoader;
		private var datos:XML;
		private var fases:XMLList;
		private var literales:XMLList;
		private var textoHelp:MovieClip = null;
		private var listadoFases:Array;
		private var clipsFases:Array = new Array();
		
		private var oks:uint = 0;
		private var kos:uint = 0;
		private var indice:uint = 0;
		private var fase:Fase = null;
			
		
		//parámetros de la aplicación
		private var urlXML:String = "xml/flechas.xml";
		
		public function Flechas() {
			stop();
			onInicio();
		}
		
		/************** apartado precarga  ******************/
		private function onInicio():void{
			Globales.__root = this;
			
			loader = new URLLoader();
			loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.addEventListener(Event.COMPLETE, onCompleteLoader);
			loader.load(new URLRequest(urlXML));
		}
		
		private function onProgress(evento:ProgressEvent):void{
			trace(evento.bytesLoaded + " de " + evento.bytesTotal);
		}
		
		private function onCompleteLoader(evento:Event):void{
			datos = new XML(loader.data);
			fases = datos..fase;
			
			Globales.literales = datos..literal;
			
			gotoAndStop("intro");
		}
		
		
		/***************************************************/
		
		/************** apartado intro  ******************/
		public function cargaIntro():void{
			onDibujaIntro();
		}
		
		private function onDibujaIntro():void{
			enunciado.htmlText = Globales.literales.(@id == "texto_enunciado")[0].toString();
			
			onListenersIntro();
		}
		
		private function onListenersIntro():void{
			b_play.funcion = lanzaJuego;
			b_help.funcion = _creaHelp;
		}
		
		public function lanzaJuego(evento:MouseEvent):void{
			gotoAndStop("play");
		}
		/***************************************************/
		
		
		
		/************** apartado play  ******************/
		public function cargaPlay():void{
			listadoFases = new Array();
			for each(var item:XML in fases){
				listadoFases.push(item);
			}
			listadoFases = Tools.randomiza(listadoFases);
			
			for(var i:uint=0; i<clipsFases.length; i++){
				clipsFases[i].destroy();
			}
			clipsFases = new Array();
			for(i=0; i<listadoFases.length; i++){
				clipsFases.push(new Fase(listadoFases[i]));
			}
			
			oks = 0;
			kos = 0;
			indice = 0;
			
			
			onDibujaPlay();
		}
		
		private function onDibujaPlay():void{
			creaFase();
			
			onListenersPlay();
		}
		
		private function _anterior(evento:MouseEvent):void{
			indice -= 2;
			creaFase();
		}
		
		private function _siguiente(evento:MouseEvent):void{
			creaFase();
		}
		
		private function creaFase():void{
			if(fase != null){
				removeChild(fase);
			}
			if(indice < clipsFases.length){
				fase = clipsFases[indice];
				b_anterior.visible = indice != 0;
				indice ++;
				addChild(fase);
			}else{
				fase = null;
				lanzaGameOver();
			}
		}
		
		private function lanzaGameOver():void{
			gotoAndStop("gameOver");
		}
		
		private function onListenersPlay():void{
			b_anterior.funcion = _anterior;
			b_siguiente.funcion = _siguiente;
		}
		/***************************************************/
		
		
		
		/************** apartado gameOver  ******************/
		public function cargaGameOver():void{
			controlresultados();
			onDibujaGameOver();
		}
		
		private function controlresultados():void{
			for(var i:uint=0; i<clipsFases.length; i++){
				var _fase:Fase = clipsFases[i];
				for(var iP:uint=0; iP<_fase.clipPreguntas.numChildren; iP++){
					var pregunta:Pregunta = _fase.clipPreguntas.getChildAt(iP) as Pregunta;
					if(pregunta.resultado){
						oks ++;
					}else{
						kos ++;
					}
				}
			}
		}
		
		private function onDibujaGameOver():void{
			ok.text = String(oks);
			ko.text = String(kos);
			
			onListenersGameOver();
		}
		
		private function onListenersGameOver():void{
			b_volver.funcion = lanzaJuego;
		}
		/***************************************************/
		
		
		/************** apartado AYUDA  ******************/
		private function _creaHelp(evento:MouseEvent):void{
			if(textoHelp == null){
				textoHelp = new TextoHelp();
				textoHelp.texto.htmlText = Globales.literales.(id="texto_descripcion")[0].toString();
				textoHelp.addEventListener(MouseEvent.CLICK, _borrahelp);
				addChild(textoHelp);
			}
		}
		
		private function _borrahelp(evento:MouseEvent):void{
			textoHelp.removeEventListener(MouseEvent.CLICK, _borrahelp);
			removeChild(textoHelp);
			textoHelp = null;
		}
		/***************************************************/
	}
	
}
