<script lang="ts">
	import { page } from "$app/state";
	import type { PageData } from "./$types";
	import { onMount } from "svelte";

	let { data }: { data: PageData } = $props();
	const apiBase = "/api";
	let open = $state(false);

	onMount(() => requestAnimationFrame(() => { open = true; }));

	function signIn() {
		window.location.href = `${apiBase}/auth/login`;
	}
</script>

<main class="overflow-x-hidden">
	<div class="w-screen h-screen relative bg-[#180c04] overflow-hidden select-none">

		<div class="fixed top-0 left-4 z-50">
			<img src="/images/flag-orpheus-top.svg" alt="Orpheus Flag"
				 class="transition-all duration-300 hover:opacity-65 cursor-pointer"
				 style="width: clamp(130px, 13vw, 220px); height: auto;" />
		</div>

		{#if !data.user}
			{#if page.url.searchParams.get("error")}
				<p class="absolute top-4 left-1/2 -translate-x-1/2 z-50 text-red-300 text-sm">
					Authentication error. Please try again.
				</p>
			{/if}
			<button onclick={() => signIn()}
					class="fixed top-0 right-6 z-50 cursor-pointer transition-opacity duration-300 hover:opacity-60">
				<img src="/images/1/Sign-fixed.png"
					 class="pointer-events-none select-none"
					 style="width: clamp(130px, 13vw, 220px); height: auto;"
					 alt="Sign In" />
			</button>
		{/if}

		<img src="/images/1/Stage-fixed.jpg"
			 class="absolute inset-0 w-full h-full object-cover pointer-events-none select-none z-0"
			 alt="Stage" />

		<img src="/images/1/Curtain-fixed.png"
			 class="absolute left-0 top-0 h-[80%] w-auto pointer-events-none select-none z-20"
			 alt="Left Curtain" />
		<img src="/images/1/Curtain-fixed.png"
			 class="absolute right-0 top-0 h-[80%] w-auto pointer-events-none select-none z-20 scale-x-[-1]"
			 alt="Right Curtain" />

		<div class="absolute pointer-events-none select-none z-10"
			 style="
			aspect-ratio: 16 / 9;
			width: max(100vw, calc(100vh * 16 / 9));
			height: max(100vh, calc(100vw * 9 / 16));
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
		 ">

			<div class="absolute flex flex-col items-center"
				 style="top: 13%; left: 50%; transform: translateX(-50%); width: 43.5%;">
				<p style="
				font-family: 'IM Fell DW Pica', serif;
				font-style: italic;
				font-size: clamp(1rem, 2vw, 2rem);
				color: #fff8e7;
				letter-spacing: 0.02em;
				white-space: nowrap;
				text-shadow:
					0 0 10px rgba(255,200,80,0.9),
					0 0 20px rgba(255,180,50,0.7),
					0 0 40px rgba(255,150,20,0.5),
					0 0 80px rgba(255,120,0,0.3);
				margin: 0; padding: 0;
				text-align: center;
				margin-top: 50px;
				position: absolute;
			">Build a story. Then live inside it.</p>

				<img src="/images/1/Logo-fixed.png"
					 class="pointer-events-none select-none w-full h-auto"
					 alt="Paradox Logo" />
			</div>
		</div>

		<div class="absolute inset-x-0 bottom-0 flex flex-col items-center pointer-events-none select-none z-30"
			 style="padding-bottom: clamp(1%, 2vh, 4%);">

			<img src="/images/1/Mask-fixed.png"
				 class="pointer-events-none select-none relative z-30"
				 style="width: clamp(120px, 18vw, 280px); height: auto; margin-bottom: -2.5%;"
				 alt="Mask" />

			<div class="relative pointer-events-none select-none z-20"
				 style="width: clamp(300px, 58vw, 860px);">
				<img src="/images/1/Board-fixed.png"
					 class="w-full h-auto pointer-events-none select-none"
					 alt="Board" />
				<input type="email" name="email"
					   class="font-myFont font-bold absolute bg-transparent text-gray-300 text-center border-none outline-none pointer-events-auto"
					   style="
						width: 85%;
						left: 7.5%;
						top: 55%;
						transform: translateY(-30%);
						font-size: clamp(1.3rem, 2.5vw, 3rem);
						letter-spacing: 0.08em;
					"
					   placeholder="ENTER YOUR EMAIL HERE..." />
			</div>
		</div>

	</div>

<!--	<div class="w-screen h-screen overflow-hidden border-t-8 border-[#732e01] flex flex-col items-center justify-center pointer-events-none select-none z-30"-->
<!--		 style="background: radial-gradient(ellipse at center, #7a4010 0%, #3d1c06 45%, #150800 100%)">-->
<!--		&lt;!&ndash; Needs to be fixed as the resolution is bad &ndash;&gt;-->
<!--		<img src="/images/2/Instructions.png" alt="Instructions" class="w-[65%]">-->
<!--	</div>-->
</main>

<style>
	input:-webkit-autofill,
	input:-webkit-autofill:hover,
	input:-webkit-autofill:focus {
		-webkit-box-shadow: 0 0 0 1000px transparent inset !important;
		-webkit-text-fill-color: #9ca3af !important;
		transition: background-color 5000s ease-in-out 0s;
	}
	input { filter: none; }
</style>