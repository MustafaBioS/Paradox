<script lang="ts">
import "../app.css";
import Lenis from "lenis";
import { onMount, onDestroy } from "svelte";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

type LenisInstance = {
	raf: (time: number) => void;
	on: (event: "scroll", cb: () => void) => void;
	off: (event: "scroll", cb: () => void) => void;
	destroy: () => void;
};

let lenis: LenisInstance | null = null;

gsap.registerPlugin(ScrollTrigger);

const onTick = (time: number) => {
	if (!lenis) return;
	lenis.raf(time * 1000);
};

onMount(() => {
	lenis = new Lenis() as LenisInstance;
	lenis.on("scroll", ScrollTrigger.update);
	gsap.ticker.add(onTick);
	gsap.ticker.lagSmoothing(0);
});

onDestroy(() => {
	gsap.ticker.remove(onTick);
	lenis?.off("scroll", ScrollTrigger.update);
	lenis?.destroy();
});

let { children } = $props();</script>

<svelte:head>
	<link rel="icon" href="/images/1/imresizer-o-mask.png" />
</svelte:head>

{@render children()}
