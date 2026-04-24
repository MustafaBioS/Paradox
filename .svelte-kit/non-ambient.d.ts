
// this file is generated — do not edit it


declare module "svelte/elements" {
	export interface HTMLAttributes<T> {
		'data-sveltekit-keepfocus'?: true | '' | 'off' | undefined | null;
		'data-sveltekit-noscroll'?: true | '' | 'off' | undefined | null;
		'data-sveltekit-preload-code'?:
			| true
			| ''
			| 'eager'
			| 'viewport'
			| 'hover'
			| 'tap'
			| 'off'
			| undefined
			| null;
		'data-sveltekit-preload-data'?: true | '' | 'hover' | 'tap' | 'off' | undefined | null;
		'data-sveltekit-reload'?: true | '' | 'off' | undefined | null;
		'data-sveltekit-replacestate'?: true | '' | 'off' | undefined | null;
	}
}

export {};


declare module "$app/types" {
	export interface AppTypes {
		RouteId(): "/" | "/api" | "/api/[...slugs]" | "/faq";
		RouteParams(): {
			"/api/[...slugs]": { slugs: string }
		};
		LayoutParams(): {
			"/": { slugs?: string };
			"/api": { slugs?: string };
			"/api/[...slugs]": { slugs: string };
			"/faq": Record<string, never>
		};
		Pathname(): "/" | `/api/${string}` & {} | "/faq";
		ResolvedPathname(): `${"" | `/${string}`}${ReturnType<AppTypes['Pathname']>}`;
		Asset(): "/fonts/Avenir-Next-Condensed-Bold.ttf" | "/fonts/Bethany-Elingston.otf" | "/images/1/Board-fixed.png" | "/images/1/Board.png" | "/images/1/Curtain-fixed.png" | "/images/1/Curtain.png" | "/images/1/image 17.png" | "/images/1/imresizer-o-mask.png" | "/images/1/Logo-fixed.png" | "/images/1/Logo.png" | "/images/1/Mask-fixed.png" | "/images/1/Mask.png" | "/images/1/o-mask.png" | "/images/1/Sign-fixed.png" | "/images/1/Sign.png" | "/images/1/Stage-fixed.jpg" | "/images/1/Stage.png" | "/images/1/star.png" | "/images/2/build-cropped.png" | "/images/2/Build.png" | "/images/2/get-cropped.png" | "/images/2/Get.png" | "/images/2/Instructions.png" | "/images/2/red-spiral.png" | "/images/2/write-cropped.png" | "/images/2/Write.png" | "/images/2/yellow-spiral.png" | "/images/curtains/frame1.png" | "/images/curtains/frame2.png" | "/images/curtains/frame3.png" | "/images/curtains/frame4.png" | "/images/curtains/frame5.png" | "/images/curtains/frame6.png" | "/images/curtains/frame7.png" | "/images/faq/faq-bg.png" | "/images/faq/faq-book.png" | "/images/faq/faq-btn.png" | "/images/faq/faq-logo.png" | "/images/faq/faq-shine.png" | "/images/faq/faq-star.png" | "/images/flag-orpheus-top.svg" | "/robots.txt" | string & {};
	}
}