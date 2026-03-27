<script lang="ts">
	import { page } from "$app/state";
	import type { PageData } from "./$types";
	import { onMount } from "svelte";
	import { gsap } from "gsap";
	import { ScrollTrigger } from "gsap/ScrollTrigger";

	let { data }: { data: PageData } = $props();
	const apiBase = "/api";
	let open = $state(false);

	let email = $state('');
	let submitting = $state(false);
	let message = $state<{ type: "success" | "error"; text: string } | null>(null);
	let messagePhase = $state<'in' | 'visible' | 'out'>('in');
	const messageTimeouts: ReturnType<typeof setTimeout>[] = [];

	const frames = [
			'/images/curtains/frame7.png',
			'/images/curtains/frame6.png',
			'/images/curtains/frame5.png',
			'/images/curtains/frame4.png',
			'/images/curtains/frame3.png',
			'/images/curtains/frame2.png',
			'/images/curtains/frame1.png',
	]

	let curtainLeft: HTMLImageElement;
	let curtainRight: HTMLImageElement;

	function clearMessageTimers() {
		messageTimeouts.forEach(clearTimeout);
		messageTimeouts.length = 0;
	}

	function setMessage(payload: { type: "success" | "error"; text: string } | null) {
		clearMessageTimers();
		if (payload === null) {
			message = null;
			return;
		}
		message = payload;
		messagePhase = 'in';
		messageTimeouts.push(
			setTimeout(() => {
				messagePhase = 'visible';
			}, 10)
		);
		messageTimeouts.push(
			setTimeout(() => {
				messagePhase = 'out';
				messageTimeouts.push(
					setTimeout(() => {
						message = null;
						messagePhase = 'in';
					}, 300)
				);
			}, 4000)
		);
	}

	function dismissMessage() {
		clearMessageTimers();
		messagePhase = 'out';
		messageTimeouts.push(
			setTimeout(() => {
				message = null;
				messagePhase = 'in';
			}, 300)
		);
	}

	function signIn() {
		window.location.href = `${apiBase}/auth/login`;
	}

	async function handleSubmit() {
		const trimmed = email.trim();
		if (!trimmed) return;

		submitting = true;
		setMessage(null);

		try {
			const res = await fetch(`${apiBase}/rsvps`, {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify({ email: trimmed }),
			});

			const data = await res.json().catch(() => ({}));

			if (res.ok && data.success) {
				setMessage({ type: "success", text: "You're on the list!" });
				email = "";
			} else if (res.status === 409 || data.message?.toLowerCase().includes("already registered")) {
				setMessage({ type: "error", text: data.message ?? "This email is already registered." });
			} else {
				setMessage({ type: "error", text: data.message ?? "Something went wrong. Please try again." });
			}
		} catch {
			setMessage({ type: "error", text: "Something went wrong. Please try again." });
		} finally {
			submitting = false;
		}
	}

	let hero: HTMLElement;

	onMount(() => {
		requestAnimationFrame(() => { open = true; });

		gsap.registerPlugin(ScrollTrigger);

		ScrollTrigger.create({
			trigger: hero,
			pin: true,
			start: 'top top',
			end: '+1500',
			scrub: 1,
			onUpdate: (self) => {
				const curtainProgress = Math.min(self.progress / 0.5, 1);
				const index = Math.floor(curtainProgress * (frames.length - 1));
				curtainLeft.src = frames[index];
				curtainRight.src = frames[index];
			}
		});
	});

</script>

<main class="overflow-x-hidden">
	<div class="w-screen h-screen bg-[#180c04] select-none z-10" bind:this={hero}>

		<div class="flex items-start justify-end">
			<button title="FAQ" class="faqBtn z-40 m-12 mr-14 rotate-12">
				<img src="/images/1/o-mask.png" class="faqMask z-50 w-[clamp(40px,5vw,65px)]" alt="Paradox Mask"/>
			</button>
		</div>

		<a class="fixed top-0 left-4 z-50" href="https://hackclub.com/">
			<img src="/images/flag-orpheus-top.svg" alt="Orpheus Flag"
				 class="transition-all duration-300 hover:opacity-65 cursor-pointer h-auto w-[clamp(130px,13vw,220px)]"/>
		</a>

		<div class="h-screen inset-0 w-full bg-black z-50 fixed opacity-55 hidden pointer-events-none select-none"></div>

<!--		<div class="h-full w-full absolute flex items-center justify-center z-50 inset-0 pointer-events-none select-none">-->
<!--			<div class="bg-black h-40 w-40"></div>-->
<!--		</div>-->

		{#if !data.user}
			{#if page.url.searchParams.get("error")}
				<p class="absolute top-4 left-1/2 -translate-x-1/2 z-50 text-red-300 text-sm">
					Authentication error. Please try again.
				</p>
			{/if}
<!--			<button onclick={() => signIn()}-->
<!--					class="fixed top-0 right-6 z-50 cursor-pointer transition-opacity duration-300 hover:opacity-60">-->
<!--				<img src="/images/1/Sign-fixed.png"-->
<!--					 class="pointer-events-none select-none"-->
<!--					 style="width: clamp(130px, 13vw, 220px); height: auto;"-->
<!--					 alt="Sign In" />-->
<!--			</button>-->
		{/if}

		<img src="/images/1/Stage-fixed.jpg"
			 class="absolute inset-0 w-full h-full object-cover pointer-events-none select-none z-0"
			 alt="Stage" />

		<img src="/images/1/Curtain-fixed.png"
			 bind:this={curtainLeft}
			 class="absolute left-0 top-0 h-[80%] w-auto pointer-events-none select-none z-50"
			 alt="Left Curtain" />
		<img src="/images/1/Curtain-fixed.png"
			 bind:this={curtainRight}
			 class="absolute right-0 top-0 h-[80%] w-auto pointer-events-none select-none z-50 scale-x-[-1]"
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

			<div class="relative pointer-events-none select-none z-20"
				 style="width: clamp(300px, 58vw, 860px);">

				<img src="/images/1/Mask-fixed.png"
					 class="pointer-events-none select-none absolute left-1/2 z-30"
					 style="
               width: clamp(100px, 15vw, 265px);
               height: auto;
               transform: translateX(-50%) translateY(-82%);
               top: 0;
             "
					 alt="Mask" />

				<form class="contents" onsubmit={(e) => { e.preventDefault(); if (!submitting) handleSubmit(); }}>
					<button type="submit"
							disabled={submitting}
							class="absolute z-30 star border-0 bg-transparent p-0 cursor-pointer"
							style="
               width: clamp(40px, 8vw, 120px);
               height: auto;
               left: -3%;
               top: 10%;
               transform: translateY(-50%);
             "
							aria-label="Submit RSVP">
						<img src="/images/1/star.png"
							 alt="Star"
							 class="pointer-events-none w-full h-auto block"
						/>
					</button>

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
						   font-size: clamp(1.0rem, 2.5vw, 3rem);
						   letter-spacing: 0.08em;
					   "
					   bind:value={email}
					   disabled={submitting}
					   placeholder="ENTER YOUR EMAIL HERE..." />
				</form>
			</div>
		</div>

		<!-- Notification toast: fixed top center -->
		{#if message}
			<div class="fixed top-6 inset-x-0 flex flex-col items-center gap-2 z-50 pointer-events-none">
				<div
					class="notification-toast pointer-events-auto flex items-start justify-between gap-3 px-5 py-3 border-2 font-medium max-w-sm w-full shadow-sm transition-all duration-300 ease-out {message.type === 'error' ? 'notification-toast-error' : 'notification-toast-success'} {messagePhase !== 'visible' ? 'notification-toast-hidden' : ''}"
				>
					<span>{message.text}</span>
					<button
						type="button"
						onclick={dismissMessage}
						class="notification-dismiss"
						aria-label="Dismiss"
					>✕</button>
				</div>
			</div>
		{/if}

	</div>

	<div class="w-screen h-screen overflow-hidden border-t-8 border-[#732e01] mt-[-100vh] relative flex items-center justify-center pointer-events-none select-none z-30"
		 style="background: radial-gradient(ellipse at center, #7a4010 0%, #3d1c06 45%, #150800 100%)">

	</div>
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

	.faqBtn {
		transition: all 0.3s ease;
	}

	.faqBtn:hover {
		transform: rotate(0);
		scale: 1.10;
		opacity: 0.8;
	}

	.star {
		transition: 0.3s ease all;
		cursor: pointer;
		pointer-events: auto;
	}

	.star:hover:not(:disabled) {
		opacity: 0.75;
	}

	.star:disabled {
		cursor: not-allowed;
		opacity: 0.7;
	}

	/* Notification toast */
	.notification-toast {
		font-family: var(--font-myFont), sans-serif;
	}
	.notification-toast-success {
		background-color: #c8e6d8;
		border-color: #61453a;
		color: #61453a;
	}
	.notification-toast-error {
		background-color: #fecaca;
		border-color: #61453a;
		color: #61453a;
	}
	.notification-toast-hidden {
		opacity: 0;
		transform: translateY(-0.5rem);
	}
	.notification-dismiss {
		flex-shrink: 0;
		opacity: 0.6;
		background: transparent;
		border: none;
		color: inherit;
		padding: 0;
		cursor: pointer;
		font-size: 1.125rem;
		line-height: 1;
	}
	.notification-dismiss:hover {
		opacity: 1;
	}

</style>