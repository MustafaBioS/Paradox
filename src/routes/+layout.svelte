<script lang="ts">
import "../app.css";
import Lenis from "lenis";
import { onMount } from "svelte";
import { page } from '$app/state';


onMount(() => {
	if (page.url.pathname === "/faq") {
		return
	} else {
		const lenis = new Lenis();

		const raf = (time: number) => {
			lenis.raf(time);
			requestAnimationFrame(raf);
		};

		requestAnimationFrame(raf);

		return () => {
			lenis.destroy();
		};
	}
});

let { children } = $props();</script>

<svelte:head>
	<link rel="icon" href="/images/1/imresizer-o-mask.png" />
</svelte:head>

{@render children()}
