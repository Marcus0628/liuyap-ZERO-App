import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:zero/styles/color.dart';
import 'package:expandable/expandable.dart';

class Tips extends StatefulWidget {
  const Tips({super.key});

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: topbar,
        title: null,
        centerTitle: true,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(25),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center, // Center the contents horizontally
              children: [
                const SizedBox(width: 10.0),
                Text(
                  "Eco-Friendly Tips",
                  style: TextStyle(
                    fontSize: 28,
                    color: word,
                    fontFamily: "FjallaOne",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 40, top: 40),
            child: Row(
              children: [
                Flexible(
                  child: Text('Begin Saving the Earth \nToday',
                    style: TextStyle(
                      color: word,
                      fontSize: 20,
                      fontFamily: "PathwayGothicOne",
                    )),
                ),
                SizedBox(width: 40),
                Container(
                  width: 150,
                  height: 100,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/saveplanet.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],

            ),
          ),


          Divider(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ExpandablePanel(
              header: Text('Reduce Food Waste at Home',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
              collapsed: Text(
                'Food waste at home contributes to environmental degradation. '
                    'To reduce waste, plan meals, store food properly, and '
                    'use leftovers creatively. Composting organic waste can '
                    'also help nourish soil and reduce methane emissions.',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 14,
                ),
                maxLines: 5,
              ),
              expanded: Text(
                'Here are some tips to reduce food waste at home:\n'
                    '- Plan your meals and make a shopping list to avoid overbuying.\n'
                    '- Store perishable items properly to prolong freshness.\n'
                    '- Get creative with leftovers by incorporating them into new dishes.\n'
                    '- Consider composting organic waste to create nutrient-rich soil.\n',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Divider(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ExpandablePanel(
              header: Text('Choose Sustainable Packaging',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
              collapsed: Text(
                'Opting for sustainable packaging can help reduce waste and minimize environmental impact. '
                  'Look for products with eco-friendly packaging, such as biodegradable materials or '
                  'recycled content. Avoid single-use plastics whenever possible and support brands '
                  'that prioritize sustainability in their packaging choices.',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 14,
                ),
                maxLines: 5,
              ),
              expanded: Text(
                'Consider the following tips for choosing sustainable packaging:\n'
                  '- Look for products with minimal or recyclable packaging.\n'
                  '- Choose items packaged in materials like glass, paper, or aluminum that are easily recyclable.\n'
                  '- Avoid single-use plastics such as plastic bags, straws, and packaging whenever possible.\n'
                  '- Support brands that use biodegradable or compostable packaging materials.\n',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Divider(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ExpandablePanel(
              header: Text('Educate Yourself and Others About Food Systems',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
              collapsed: Text(
                'Understanding food systems can empower individuals to make '
                    'more informed choices. Learn about where your food comes from, '
                    'how it is produced, and its impact on the environment and society. '
                    'Share this knowledge with others to inspire change.',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 14,
                ),
                maxLines: 5,
              ),
              expanded: Text(
                 'Ways to educate yourself and others about food systems:\n'
                    '- Read books, articles, and documentaries about food production and agriculture.\n'
                    '- Visit farms, community gardens, and agricultural fairs to learn firsthand.\n'
                    '- Support organizations and initiatives promoting food education and sustainability.\n'
                    '- Engage in conversations with friends, family, and communities about food-related issues.\n',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Divider(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            height: 25,
          ),
          SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left:25, right: 25),
                  child: Container(
                    width: 50,
                    height: 220,
                  
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/bottomplanet.png',
                        width: 50,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

        ],
      ),
    );
  }
}