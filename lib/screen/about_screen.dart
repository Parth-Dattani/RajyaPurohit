import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/const.dart';

class AboutScreen extends StatelessWidget {
  static const pageId = "/about";

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepSpaceBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle('About COMPASSIONA'),
                _sectionParagraph(
                  'Compassiona was born from a simple question: when disaster strikes and millions of people want to help, what if they could — right from where they are, right at that moment?',
                ),
                _sectionParagraph(
                  'Emergency services provide physical aid. Relief organizations rebuild infrastructure. But Compassiona addresses something different — the universal human need to come together in compassion when the world is hurting. It is a platform that mobilizes collective healing meditation in real-time, turning individual concern into shared action.',
                ),
                _sectionTitle('How It Started'),
                _sectionParagraph(
                  'The idea for Compassiona came during a series of devastating natural disasters that left communities in crisis. Watching the suffering unfold, one thing became clear — millions of compassionate people around the world wanted to do something meaningful, but had no way to channel that energy together. Drawing on research into collective consciousness and the documented effects of group meditation, Compassiona was created to solve that problem: a way for anyone, anywhere, to contribute healing energy instantly through synchronized meditation.',
                ),
                _sectionParagraph(
                  'What began as a single idea has grown into a worldwide collective meditation community spanning every continent, connecting people across all borders, religions and backgrounds in shared moments of focused compassion.',
                ),
                _sectionTitle('A Different Kind of Meditation App'),
                _sectionParagraph(
                  'Most meditation apps focus on individual well-being. Compassiona is different. It is built entirely around collective action — bringing thousands of people together at the same time for a shared purpose.',
                ),
                _sectionParagraph(
                  'Compassiona operates on a unique Two-Phase model. Before predicted events like hurricanes or floods, the community gathers for pre-event meditation sessions aimed at sending protective energy. After disasters occur, ongoing post-event healing sessions support recovery and rebuilding. This means collective meditation support is not just reactive but proactive.',
                ),
                _sectionParagraph(
                  'Compassiona does not replace traditional disaster relief. It adds a new dimension — immediate, global and driven by collective compassion.',
                ),
                _sectionTitle('The Science'),
                _sectionParagraph(
                  'Research on collective consciousness suggests that when large groups focus their intention together, measurable effects can occur. Studies on group meditation have documented reduced violence in conflict zones, decreased crime rates, improved collective well-being, and measurable shifts in random event generators. While the science continues to evolve, the evidence supports what meditators have known for centuries — focused collective intention has power.',
                ),
                _sectionTitle('What Drives COMPASSIONA'),
                _sectionParagraph(
                  'Three principles guide everything Compassiona does. Immediacy — when disaster strikes, every moment matters, and the platform enables collective meditation to begin within minutes. Inclusivity — healing energy knows no borders, and Compassiona welcomes people of all faiths, backgrounds and experience levels. Transparency — real-time counters show exactly how many people are meditating together, so every participant can see the collective power they are part of.',
                ),
                _sectionTitle('Be Part of It'),
                _sectionParagraph(
                  'Whether you are an experienced meditator or completely new to the practice, Compassiona gives you a way to contribute to something bigger. Every session you join strengthens the collective. Every heart that joins makes the meditation more powerful.',
                ),
                _sectionParagraph(
                  'Every disaster reminds us that we are all connected. One planet, one humanity. Compassiona turns that connection into action.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.yellow,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _sectionParagraph(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        content,
        style: TextStyle(
          color: Colors.white.withOpacity(0.82),
          fontSize: 16,
          height: 1.7,
        ),
      ),
    );
  }

  Widget _infoCard({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF12203A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.healingTeal.withOpacity(0.18),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.healingTeal,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
