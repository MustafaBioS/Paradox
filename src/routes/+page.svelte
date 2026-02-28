<script lang="ts">
	import { page } from "$app/state";
	import type { PageData } from "./$types";
	import { onMount } from "svelte";

	let { data }: { data: PageData } = $props();

	const apiBase = "/api";

	let open = $state(false);

	onMount(() => {
		requestAnimationFrame(() => {
			open = true;
		});
	});

	function signIn() {
		window.location.href = `${apiBase}/auth/login`;
	}
</script>

<main class="overflow-x-hidden">
	
	<div class="w-screen h-screen relative bg-[#180c04] overflow-hidden select-none">

		<div class="fixed top-0 left-4 z-50">
			<img src="/images/flag-orpheus-top.svg" alt="Orpheus Flag" class="w-48 transition-all duration-300 hover:opacity-65 cursor-pointer" />
		</div>

		{#if data.user}
			<a href="{apiBase}/auth/logout"
			   class="absolute top-4 right-4 z-30 cursor-pointer transition duration-300 hover:opacity-70"
			>
				<img src="/images/1/Sign.png" class="h-[70px] w-auto" alt="Sign Out" />
			</a>
		{:else}
			{#if page.url.searchParams.get("error")}
				<p class="absolute top-4 left-4 z-30 px-3 py-1 rounded">
					Authentication error. Please try again.
				</p>
			{/if}
			<!--onclick={() => signIn()}-->
			<div class="fixed right-0 top-0 h-[100px] w-[230px] mr-7 z-50 transition duration-300 hover:opacity-60 cursor-pointer">
				<img src="/images/1/Sign.png"
					 class="w-[1000px] right-0 top-0 fixed pointer-events-none select-none"
					 alt="Sign"
				/>
			</div>
		{/if}

		<img
				src="/images/1/Stage.png"
				class="h-full w-full object-contain pointer-events-none select-none"
				alt="Stage"
		/>

		<div class="absolute z-40 h-full w-full left-0 top-0 pointer-events-none select-none ">
			<img src="/images/1/Curtain.png"
				 class="left-0 top-0 w-auto h-[90%] object-contain z-10"
				 alt="Left Curtain" />
		</div>

		<div class="absolute z-40 scale-x-[-1] h-full w-full right-0 top-0 pointer-events-none select-none">
			<img src="/images/1/Curtain.png"
				 class="right-0 top-0 w-auto h-[90%] object-contain z-50"
				 alt="Left Curtain" />
		</div>

		<div class="absolute inset-0 flex flex-col items-center justify-center z-20 pointer-events-none select-none pb-[21%]">
			<p
					class="text-amber-100 italic mb-4 text-center pointer-events-none select-none"
					style="font-family: 'IM Fell DW Pica', serif; font-weight: 400; font-style: italic; font-size: clamp(1.5rem, 3vw, 2.5rem); text-shadow:
					0 0 10px rgba(255, 200, 80, 0.9),
					0 0 20px rgba(255, 180, 50, 0.7),
					0 0 40px rgba(255, 150, 20, 0.5),
					0 0 80px rgba(255, 120, 0, 0.3);
					color: #fff8e7;

					letter-spacing: 0.02em;"
			>
				Build a story. Then live inside it.
			</p>
			<img
					src="/images/1/Logo.png"
					class="w-auto max-w-[80vw] object-contain z-10 pointer-events-none select-none"
					style="height: clamp(120px, 25vw, 280px); drop-shadow: 0 8px 32px rgba(0,0,0,0.6);"
					alt="Paradox Logo"
			/>
		</div>

		<div class="z-50 absolute inset-0 flex items-center justify-center pointer-events-none select-none">
			<div class="z-50 relative" style="width: clamp(320px, 55vw, 900px);">
				<img src="/images/1/Mask.png"
					 class="absolute w-full pointer-events-none z-20"
					 alt="Mask"
				/>
				<img src="/images/1/Board.png"
					 class="w-full h-full pointer-events-none z-10 relative"
					 alt="Board"
				/>
				<input type="email"
					   name="email"
					   class="z-50 absolute bg-transparent text-gray-400 font-myFont font-bold text-center border-none outline-none"
					   style="
							width: 65%;
							left: 18.5%;
							bottom: 10%;
							font-size: clamp(0.5rem, 2.5vw, 3rem);
						"
					   placeholder="ENTER YOUR EMAIL HERE..."
				/>
			</div>
		</div>


	</div>

	<div class="w-screen h-screen overflow-hidden border-t-8 border-[#732e01]"
		 style="background: radial-gradient(ellipse at center, #7a4010 0%, #3d1c06 45%, #150800 100%)">

		<div class="flex h-full px-16 py-10 gap-12">

			<div class="flex flex-col justify-between w-1/2">

				<div class="flex flex-col items-start">
					<img src="/images/2/Build.png" class="w-[45vw] max-w-[500px] h-auto" alt="Build" />
				</div>

				<div class="flex flex-col items-start">
					<img src="/images/2/Get.png" class="w-[45vw] max-w-[500px] h-auto" alt="Get" />
				</div>

			</div>

			<div class="flex flex-col items-center justify-center w-1/2">
				<img src="/images/2/Write.png" class="w-[35vw] max-w-[500px] h-auto" alt="Write" />
			</div>

		</div>

	</div>

</main>


<style>
	input:-webkit-autofill,
	input:-webkit-autofill:hover,
	input:-webkit-autofill:focus {
		-webkit-box-shadow: 0 0 0px 1000px transparent inset !important;
		-webkit-text-fill-color: #9ca3af !important;
		transition: background-color 5000s ease-in-out 0s;
	}

	input {
		filter: none;
	}
</style>