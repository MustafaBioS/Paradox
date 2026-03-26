<script>
import "../app.css";
import Lenis from "lenis";
import { onMount, onDestroy } from "svelte";

let lenis;

onMount(() => {
	lenis = new Lenis();

	function raf(time) {
		lenis.raf(time);
		requestAnimationFrame(raf);
	}

	requestAnimationFrame(raf);
});

onDestroy(() => {
	lenis?.destroy();
});

let { children } = $props();</script>

<svelte:head>
	<link rel="icon" href="/images/1/o-mask.png" />
</svelte:head>

{@render children()}
