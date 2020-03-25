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
	import Jorge.Test.Pregunta;
	import flash.display.Loader;
	
	
	public class Test extends MovieClip {
		private var loader:URLLoader;
		private var datos:XML;
		private var fases:XMLList;
		private var literales:XMLList;
		private var textoHelp:MovieClip = null;
		private var listadoFases:Array;
		private var pregunta:Pregunta = null;
		private var indice:uint = 0;
		//para cargar swf externos
		private var scene1:Loader = null;
		private var scene1Url:URLRequest = null;
		
		//----------
		//private var banderaSwf:Boolean = false;
		private var atrE
		private var oks:uint = 0;
		private var kos:uint = 0;
			
		
		//parámetros de la aplicación
		private var urlXML:String = "xml/test.xml";
		
		public function Test() {
			
			//stop();
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
			
			this.alpha = 0;
			gotoAndStop("intro");
		}
		
		
		/***************************************************/
		
		/************** apartado intro  ******************/
		public function cargaIntro():void{
			onDibujaIntro();
		}
		
		private function onDibujaIntro():void{
			enunciado.htmlText = Globales.literales.(@id == "texto_enunciado")[0].toString();
			
			TweenLite.to(this, 1, {alpha:1});
			
			onListenersIntro();
		}
		
		private function onListenersIntro():void{
			//btnJuego2.funcion = lanzarJuegoImg;
			//btnJuego1.funcion = lanzarJuego1;
			b_play.funcion = lanzaJuego;
			
		}
		public function lanzarJuego1(enveto:MouseEvent):void{
			//gotoAndStop("intro");
			if(pregunta != null){
				pregunta.destroy();
				removeChild(pregunta);
			}
			trace("hola");
			if(scene1 != null){
			removeChild(scene1);
			scene1 = null;
			scene1Url = null;
			}
			gotoAndStop("intro");
			
		}
		public function lanzaJuego(evento:MouseEvent):void{
			alpha = 0;
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
			
			oks = 0;
			kos = 0;
			indice = 0;
			pregunta = null;
			
			onDibujaPlay();
		}
		
		private function onDibujaPlay():void{
			TweenLite.to(this, 1, {alpha:1});
			
			creaPregunta();
			
			onListenersPlay();
		}
		
		private function onListenersPlay():void{
			b_siguiente.funcion = avanzaFase;
			
			b_help.funcion = _creaHelp;
		}
		
		private function avanzaFase(evento:MouseEvent):void{
			if(pregunta.resultado){
				oks ++;
			}else{
				kos ++;
			}
			if(indice < listadoFases.length - 1){
				indice ++;
				creaPregunta();
			}else{
				pregunta.destroy();
				removeChild(pregunta);
				alpha = 0;
				gotoAndStop("gameOver");
			}
		}
		
		private function creaPregunta():void{
			if(pregunta != null){
				pregunta.destroy();
				removeChild(pregunta);
			}
			pregunta = new Pregunta(listadoFases[indice]);
			addChild(pregunta);
		}
		
		/***************************************************/
		
		
		
		/************** apartado gameOver  ******************/
		public function cargaGameOver():void{
			onDibujaGameOver();
		}
		
		private function onDibujaGameOver():void{
			ok.text = String(oks);
			ko.text = String(kos);
			
			TweenLite.to(this, 1, {alpha:1});
			
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
				textoHelp.alpha = 0;
				TweenLite.to(textoHelp, 1, {alpha:1});
				addChild(textoHelp);
			}
		}
		
		private function _borrahelp(evento:MouseEvent):void{
			textoHelp.removeEventListener(MouseEvent.CLICK, _borrahelp);
			removeChild(textoHelp);
			textoHelp = null;
		}
		/***************************************************/
		/***********aparatdo par juego de img****/
		private function lanzarJuegoImg(evento:MouseEvent):void{
			gotoAndStop("juegoImg");
			this.loadSwf();
			
			
			
		}
		private function loadSwf():void{
			if(pregunta != null){
				pregunta.destroy();
				removeChild(pregunta);
			}
			if(scene1 == null){
				scene1 = new Loader();
				scene1Url = new URLRequest("DragDrop.swf");
			}
			else{
				removeChild(scene1);
			}
			
			
			scene1.load(scene1Url);
			addChild(scene1);
			
			scene1.x = 700;
			scene1.y = 150;
			
		}
		
		
		
		
		/*++++++++++++++++++++++++++++++++++++++++++++++++/*/
	}
	
}
